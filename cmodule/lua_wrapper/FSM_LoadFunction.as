package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_LoadFunction extends Machine 
    {

        public static const intRegCount:int = 18;
        public static const NumberRegCount:int = 1;

        public var i10:int;
        public var i11:int;
        public var i12:int;
        public var i13:int;
        public var i14:int;
        public var i15:int;
        public var i17:int;
        public var f0:Number;
        public var i16:int;
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
            var _local_1:FSM_LoadFunction;
            _local_1 = new (FSM_LoadFunction)();
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
                    public::mstate.esp = (public::mstate.esp - 72);
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li32(this.i0);
                    this.i2 = li16(this.i1 + 52);
                    this.i2 = (this.i2 + 1);
                    si16(this.i2, (this.i1 + 52));
                    this.i1 = li32(public::mstate.ebp + 12);
                    this.i3 = this.i0;
                    this.i2 = (this.i2 & 0xFFFF);
                    if (uint(this.i2) < uint(201)) goto _label_1;
                    this.i2 = __2E_str156317;
                    this.i4 = li32(this.i0 + 12);
                    this.i5 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i6 = __2E_str3159;
                    si32(this.i5, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i6, (public::mstate.esp + 12));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 1:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i4 = 3;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_1: 
                    this.i2 = 9;
                    this.i4 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i4, public::mstate.esp);
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaF_newproto.start();
                    return;
                case 3:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i5 = li32(this.i3);
                    this.i5 = li32(this.i5 + 8);
                    si32(this.i4, this.i5);
                    si32(this.i2, (this.i5 + 8));
                    this.i2 = li32(this.i3);
                    this.i5 = li32(this.i2 + 28);
                    this.i6 = li32(this.i2 + 8);
                    this.i5 = (this.i5 - this.i6);
                    if (this.i5 > 12) goto _label_3;
                    this.i5 = li32(this.i2 + 44);
                    if (this.i5 < 1) goto _label_2;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i5 = (this.i5 << 1);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_3;
                    
                _label_2: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i5 = (this.i5 + 1);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_3: 
                    this.i2 = 4;
                    this.i5 = li32(this.i3);
                    this.i6 = li32(this.i5 + 8);
                    this.i6 = (this.i6 + 12);
                    si32(this.i6, (this.i5 + 8));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = (public::mstate.ebp + -28);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_LoadBlock.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i2 = li32(public::mstate.ebp + -28);
                    if (!(!(this.i2 == 0)))
                    {
                        this.i2 = 0;
                        goto _label_4;
                    };
                    this.i5 = li32(this.i0 + 8);
                    this.i6 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaZ_openspace.start();
                    return;
                case 7:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i5 = li32(public::mstate.ebp + -28);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_LoadBlock.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i5 = li32(public::mstate.ebp + -28);
                    this.i6 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = (this.i5 + -1);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 9:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_4: 
                    this.i5 = 4;
                    this.i1 = ((this.i2 == 0) ? this.i1 : this.i2);
                    si32(this.i1, (this.i4 + 32));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = (public::mstate.ebp + -16);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_LoadBlock.start();
                    return;
                case 10:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li32(public::mstate.ebp + -16);
                    this.i2 = (this.i4 + 32);
                    if (!(this.i1 < 0)) goto _label_5;
                    this.i1 = __2E_str156317;
                    this.i5 = li32(this.i0 + 12);
                    this.i6 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i7 = __2E_str2158;
                    si32(this.i6, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i7, (public::mstate.esp + 12));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 11:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i1 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i5 = 3;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 12:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = li32(public::mstate.ebp + -16);
                    
                _label_5: 
                    this.i5 = 4;
                    si32(this.i1, (this.i4 + 60));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = (public::mstate.ebp + -4);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_LoadBlock.start();
                    return;
                case 13:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li32(public::mstate.ebp + -4);
                    if (!(this.i1 < 0)) goto _label_6;
                    this.i1 = __2E_str156317;
                    this.i5 = li32(this.i0 + 12);
                    this.i6 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i7 = __2E_str2158;
                    si32(this.i6, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i7, (public::mstate.esp + 12));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 14:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i1 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i5 = 3;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 15:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = li32(public::mstate.ebp + -4);
                    
                _label_6: 
                    this.i5 = 1;
                    si32(this.i1, (this.i4 + 64));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = (public::mstate.ebp + -5);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_LoadBlock.start();
                    return;
                case 16:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li8(public::mstate.ebp + -5);
                    si8(this.i1, (this.i4 + 72));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = (public::mstate.ebp + -6);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_LoadBlock.start();
                    return;
                case 17:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li8(public::mstate.ebp + -6);
                    si8(this.i1, (this.i4 + 73));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = (public::mstate.ebp + -7);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_LoadBlock.start();
                    return;
                case 18:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li8(public::mstate.ebp + -7);
                    si8(this.i1, (this.i4 + 74));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = (public::mstate.ebp + -8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_LoadBlock.start();
                    return;
                case 19:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li8(public::mstate.ebp + -8);
                    si8(this.i1, (this.i4 + 75));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = (public::mstate.ebp + -12);
                    this.i5 = 4;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_LoadBlock.start();
                    return;
                case 20:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li32(public::mstate.ebp + -12);
                    if (!(this.i1 < 0)) goto _label_7;
                    this.i1 = __2E_str156317;
                    this.i5 = li32(this.i0 + 12);
                    this.i6 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i7 = __2E_str2158;
                    si32(this.i6, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i7, (public::mstate.esp + 12));
                    state = 21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 21:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i1 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i5 = 3;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 22;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 22:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = li32(public::mstate.ebp + -12);
                    
                _label_7: 
                    this.i5 = (this.i1 + 1);
                    if (uint(this.i5) > uint(1073741823)) goto _label_9;
                    this.i5 = 0;
                    this.i6 = li32(this.i3);
                    this.i7 = li32(this.i6 + 16);
                    this.i8 = li32(this.i7 + 12);
                    this.i9 = li32(this.i7 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i10 = (this.i1 << 2);
                    si32(this.i9, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i10, (public::mstate.esp + 12));
                    state = 23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i8]());
                    return;
                case 23:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i5 == 0)) goto _label_8;
                    if (this.i10 == 0) goto _label_8;
                    this.i8 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    state = 24;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 24:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_8: 
                    this.i6 = li32(this.i7 + 68);
                    this.i6 = (this.i10 + this.i6);
                    si32(this.i6, (this.i7 + 68));
                    goto _label_10;
                    
                _label_9: 
                    this.i5 = __2E_str149;
                    this.i6 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 25;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 25:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = 0;
                    
                _label_10: 
                    this.i6 = (public::mstate.ebp + -20);
                    si32(this.i5, (this.i4 + 12));
                    si32(this.i1, (this.i4 + 44));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = (this.i1 << 2);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 26;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_LoadBlock.start();
                    return;
                case 26:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = 4;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 27;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_LoadBlock.start();
                    return;
                case 27:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li32(public::mstate.ebp + -20);
                    this.i5 = (this.i4 + 44);
                    if (!(this.i1 < 0)) goto _label_11;
                    this.i1 = __2E_str156317;
                    this.i6 = li32(this.i0 + 12);
                    this.i7 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i8 = __2E_str2158;
                    si32(this.i7, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i8, (public::mstate.esp + 12));
                    state = 28;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 28:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i1 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i6 = 3;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    state = 29;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 29:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = li32(public::mstate.ebp + -20);
                    
                _label_11: 
                    this.i6 = (this.i4 + 40);
                    this.i7 = (this.i4 + 8);
                    this.i8 = (this.i1 + 1);
                    if (uint(this.i8) > uint(357913941)) goto _label_21;
                    this.i8 = 0;
                    this.i9 = li32(this.i3);
                    this.i10 = li32(this.i9 + 16);
                    this.i11 = li32(this.i10 + 12);
                    this.i12 = li32(this.i10 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i13 = (this.i1 * 12);
                    si32(this.i12, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    si32(this.i13, (public::mstate.esp + 12));
                    state = 30;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i11]());
                    return;
                case 30:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i8 == 0)) goto _label_12;
                    if (this.i13 == 0) goto _label_12;
                    this.i11 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i9, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    state = 31;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 31:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_12: 
                    this.i9 = li32(this.i10 + 68);
                    this.i9 = (this.i13 + this.i9);
                    si32(this.i9, (this.i10 + 68));
                    si32(this.i8, this.i7);
                    si32(this.i1, this.i6);
                    if (this.i1 < 1) goto _label_22;
                    
                _label_13: 
                    this.i6 = 0;
                    this.i8 = 8;
                    do 
                    {
                        this.i9 = 0;
                        this.i10 = li32(this.i7);
                        this.i10 = (this.i10 + this.i8);
                        si32(this.i9, this.i10);
                        this.i8 = (this.i8 + 12);
                        this.i6 = (this.i6 + 1);
                        if (this.i6 >= this.i1) goto _label_22;
                    } while (true);
                    
                _label_14: 
                    this.i12 = 1;
                    this.i13 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i14 = (public::mstate.ebp + -21);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i14, (public::mstate.esp + 4));
                    si32(this.i12, (public::mstate.esp + 8));
                    state = 32;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_LoadBlock.start();
                    return;
                case 32:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i12 = (this.i6 * 12);
                    this.i14 = sxi8(li8(public::mstate.ebp + -21));
                    this.i12 = (this.i13 + this.i12);
                    if (this.i14 > 2) goto _label_15;
                    if (this.i14 == 0) goto _label_16;
                    if (!(this.i14 == 1)) goto _label_20;
                    this.i14 = 1;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i15 = (public::mstate.ebp + -22);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i15, (public::mstate.esp + 4));
                    si32(this.i14, (public::mstate.esp + 8));
                    state = 33;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_LoadBlock.start();
                    return;
                case 33:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i15 = li8(public::mstate.ebp + -22);
                    this.i15 = ((this.i15 != 0) ? 1 : 0);
                    this.i15 = (this.i15 & 0x01);
                    this.i16 = (this.i6 * 12);
                    si32(this.i15, this.i12);
                    this.i12 = (this.i13 + this.i16);
                    si32(this.i14, (this.i12 + 8));
                    this.i6 = (this.i6 + 1);
                    if (this.i6 >= this.i1) goto _label_24;
                    goto _label_14;
                    
                _label_15: 
                    if (this.i14 == 3) goto _label_17;
                    if (!(this.i14 == 4)) goto _label_20;
                    this.i14 = 4;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i14, (public::mstate.esp + 8));
                    state = 34;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_LoadBlock.start();
                    return;
                case 34:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i14 = li32(public::mstate.ebp + -32);
                    if (!(this.i14 == 0)) goto _label_18;
                    this.i14 = 0;
                    goto _label_19;
                    
                _label_16: 
                    this.i12 = 0;
                    this.i14 = (this.i6 * 12);
                    this.i13 = (this.i13 + this.i14);
                    si32(this.i12, (this.i13 + 8));
                    this.i6 = (this.i6 + 1);
                    if (this.i6 >= this.i1) goto _label_24;
                    goto _label_14;
                    
                _label_17: 
                    this.i12 = 8;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i12, (public::mstate.esp + 8));
                    state = 35;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_LoadBlock.start();
                    return;
                case 35:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i12 = (this.i6 * 12);
                    this.f0 = lf64(public::mstate.ebp + -72);
                    this.i12 = (this.i13 + this.i12);
                    sf64(this.f0, this.i12);
                    this.i13 = 3;
                    si32(this.i13, (this.i12 + 8));
                    this.i6 = (this.i6 + 1);
                    if (this.i6 >= this.i1) goto _label_24;
                    goto _label_14;
                    
                _label_18: 
                    this.i15 = li32(this.i8);
                    this.i16 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i16, public::mstate.esp);
                    si32(this.i15, (public::mstate.esp + 4));
                    si32(this.i14, (public::mstate.esp + 8));
                    state = 36;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaZ_openspace.start();
                    return;
                case 36:
                    this.i14 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i15 = li32(public::mstate.ebp + -32);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i14, (public::mstate.esp + 4));
                    si32(this.i15, (public::mstate.esp + 8));
                    state = 37;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_LoadBlock.start();
                    return;
                case 37:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i15 = li32(public::mstate.ebp + -32);
                    this.i16 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i15 = (this.i15 + -1);
                    si32(this.i16, public::mstate.esp);
                    si32(this.i14, (public::mstate.esp + 4));
                    si32(this.i15, (public::mstate.esp + 8));
                    state = 38;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 38:
                    this.i14 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_19: 
                    this.i15 = 4;
                    this.i16 = (this.i6 * 12);
                    si32(this.i14, this.i12);
                    this.i12 = (this.i13 + this.i16);
                    si32(this.i15, (this.i12 + 8));
                    this.i6 = (this.i6 + 1);
                    if (this.i6 >= this.i1) goto _label_24;
                    goto _label_14;
                    
                _label_20: 
                    this.i12 = __2E_str156317;
                    this.i13 = li32(this.i11);
                    this.i14 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i15 = __2E_str4160;
                    si32(this.i14, public::mstate.esp);
                    si32(this.i12, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    si32(this.i15, (public::mstate.esp + 12));
                    state = 39;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 39:
                    this.i12 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i12 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i13 = 3;
                    si32(this.i12, public::mstate.esp);
                    si32(this.i13, (public::mstate.esp + 4));
                    state = 40;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 40:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i6 = (this.i6 + 1);
                    goto _label_23;
                    
                _label_21: 
                    this.i8 = __2E_str149;
                    this.i9 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i9, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    state = 41;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 41:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i8 = 0;
                    si32(this.i8, this.i7);
                    si32(this.i1, this.i6);
                    if (this.i1 > 0) goto _label_13;
                    
                _label_22: 
                    this.i6 = 0;
                    this.i11 = (this.i0 + 12);
                    this.i8 = (this.i0 + 8);
                    this.i9 = (public::mstate.ebp + -32);
                    this.i10 = (public::mstate.ebp + -72);
                    
                _label_23: 
                    if (!(this.i6 >= this.i1)) goto _label_14;
                    
                _label_24: 
                    this.i1 = 4;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = (public::mstate.ebp + -36);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 42;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_LoadBlock.start();
                    return;
                case 42:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li32(public::mstate.ebp + -36);
                    if (!(this.i1 < 0)) goto _label_25;
                    this.i1 = __2E_str156317;
                    this.i6 = li32(this.i11);
                    this.i7 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i9 = __2E_str2158;
                    si32(this.i7, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i9, (public::mstate.esp + 12));
                    state = 43;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 43:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i1 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i6 = 3;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    state = 44;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 44:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = li32(public::mstate.ebp + -36);
                    
                _label_25: 
                    this.i6 = (this.i4 + 52);
                    this.i7 = (this.i4 + 16);
                    this.i9 = (this.i1 + 1);
                    if (uint(this.i9) > uint(1073741823)) goto _label_29;
                    this.i9 = 0;
                    this.i10 = li32(this.i3);
                    this.i12 = li32(this.i10 + 16);
                    this.i13 = li32(this.i12 + 12);
                    this.i14 = li32(this.i12 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i15 = (this.i1 << 2);
                    si32(this.i14, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    si32(this.i15, (public::mstate.esp + 12));
                    state = 45;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i13]());
                    return;
                case 45:
                    this.i9 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i9 == 0)) goto _label_26;
                    if (this.i15 == 0) goto _label_26;
                    this.i13 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i10, public::mstate.esp);
                    si32(this.i13, (public::mstate.esp + 4));
                    state = 46;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 46:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_26: 
                    this.i10 = li32(this.i12 + 68);
                    this.i10 = (this.i15 + this.i10);
                    si32(this.i10, (this.i12 + 68));
                    si32(this.i9, this.i7);
                    si32(this.i1, this.i6);
                    if (this.i1 < 1) goto _label_30;
                    
                _label_27: 
                    this.i6 = 0;
                    this.i9 = this.i6;
                    do 
                    {
                        this.i10 = 0;
                        this.i12 = li32(this.i7);
                        this.i12 = (this.i12 + this.i9);
                        si32(this.i10, this.i12);
                        this.i9 = (this.i9 + 4);
                        this.i6 = (this.i6 + 1);
                        if (this.i6 >= this.i1) goto _label_30;
                    } while (true);
                    
                _label_28: 
                    this.i10 = li32(this.i7);
                    this.i12 = li32(this.i2);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i12, (public::mstate.esp + 4));
                    state = 47;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_LoadFunction.start();
                    return;
                case 47:
                    this.i12 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i10 = (this.i10 + this.i9);
                    si32(this.i12, this.i10);
                    this.i9 = (this.i9 + 4);
                    this.i6 = (this.i6 + 1);
                    if (this.i6 == this.i1) goto _label_31;
                    goto _label_28;
                    
                _label_29: 
                    this.i9 = __2E_str149;
                    this.i10 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i10, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    state = 48;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 48:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i9 = 0;
                    si32(this.i9, this.i7);
                    si32(this.i1, this.i6);
                    if (this.i1 > 0) goto _label_27;
                    
                _label_30: 
                    if (!(this.i1 < 1))
                    {
                        this.i6 = 0;
                        this.i9 = this.i6;
                        goto _label_28;
                    };
                    
                _label_31: 
                    this.i1 = 4;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (public::mstate.ebp + -40);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 49;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_LoadBlock.start();
                    return;
                case 49:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li32(public::mstate.ebp + -40);
                    if (!(this.i1 < 0)) goto _label_32;
                    this.i1 = __2E_str156317;
                    this.i2 = li32(this.i11);
                    this.i6 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i7 = __2E_str2158;
                    si32(this.i6, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    si32(this.i7, (public::mstate.esp + 12));
                    state = 50;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 50:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i1 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = 3;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 51;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 51:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = li32(public::mstate.ebp + -40);
                    
                _label_32: 
                    this.i2 = (this.i1 + 1);
                    if (uint(this.i2) > uint(1073741823)) goto _label_34;
                    this.i2 = 0;
                    this.i6 = li32(this.i3);
                    this.i7 = li32(this.i6 + 16);
                    this.i9 = li32(this.i7 + 12);
                    this.i10 = li32(this.i7 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i12 = (this.i1 << 2);
                    si32(this.i10, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    si32(this.i12, (public::mstate.esp + 12));
                    state = 52;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i9]());
                    return;
                case 52:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i2 == 0)) goto _label_33;
                    if (this.i12 == 0) goto _label_33;
                    this.i9 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    state = 53;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 53:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_33: 
                    this.i6 = li32(this.i7 + 68);
                    this.i6 = (this.i12 + this.i6);
                    si32(this.i6, (this.i7 + 68));
                    goto _label_35;
                    
                _label_34: 
                    this.i2 = __2E_str149;
                    this.i6 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 54;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 54:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = 0;
                    
                _label_35: 
                    this.i6 = (public::mstate.ebp + -44);
                    si32(this.i2, (this.i4 + 20));
                    si32(this.i1, (this.i4 + 48));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = (this.i1 << 2);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 55;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_LoadBlock.start();
                    return;
                case 55:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = 4;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 56;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_LoadBlock.start();
                    return;
                case 56:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li32(public::mstate.ebp + -44);
                    if (!(this.i1 < 0)) goto _label_36;
                    this.i1 = __2E_str156317;
                    this.i2 = li32(this.i11);
                    this.i6 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i7 = __2E_str2158;
                    si32(this.i6, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    si32(this.i7, (public::mstate.esp + 12));
                    state = 57;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 57:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i1 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = 3;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 58;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 58:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = li32(public::mstate.ebp + -44);
                    
                _label_36: 
                    this.i2 = (this.i4 + 56);
                    this.i6 = (this.i4 + 24);
                    this.i7 = (this.i1 + 1);
                    if (uint(this.i7) > uint(357913941)) goto _label_43;
                    this.i7 = 0;
                    this.i9 = li32(this.i3);
                    this.i10 = li32(this.i9 + 16);
                    this.i12 = li32(this.i10 + 12);
                    this.i13 = li32(this.i10 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i14 = (this.i1 * 12);
                    si32(this.i13, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i14, (public::mstate.esp + 12));
                    state = 59;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i12]());
                    return;
                case 59:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i7 == 0)) goto _label_37;
                    if (this.i14 == 0) goto _label_37;
                    this.i12 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i9, public::mstate.esp);
                    si32(this.i12, (public::mstate.esp + 4));
                    state = 60;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 60:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_37: 
                    this.i9 = li32(this.i10 + 68);
                    this.i9 = (this.i14 + this.i9);
                    si32(this.i9, (this.i10 + 68));
                    si32(this.i7, this.i6);
                    si32(this.i1, this.i2);
                    if (this.i1 < 1) goto _label_44;
                    
                _label_38: 
                    this.i2 = 0;
                    this.i7 = this.i2;
                    do 
                    {
                        this.i9 = 0;
                        this.i10 = li32(this.i6);
                        this.i10 = (this.i10 + this.i7);
                        si32(this.i9, this.i10);
                        this.i7 = (this.i7 + 12);
                        this.i2 = (this.i2 + 1);
                        if (this.i2 >= this.i1) goto _label_44;
                    } while (true);
                    
                _label_39: 
                    this.i13 = 4;
                    this.i14 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    state = 61;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_LoadBlock.start();
                    return;
                case 61:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i13 = li32(public::mstate.ebp + -48);
                    if (!(!(this.i13 == 0)))
                    {
                        this.i13 = 0;
                        goto _label_40;
                    };
                    this.i15 = li32(this.i8);
                    this.i16 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i16, public::mstate.esp);
                    si32(this.i15, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    state = 62;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaZ_openspace.start();
                    return;
                case 62:
                    this.i13 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i15 = li32(public::mstate.ebp + -48);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i13, (public::mstate.esp + 4));
                    si32(this.i15, (public::mstate.esp + 8));
                    state = 63;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_LoadBlock.start();
                    return;
                case 63:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i15 = li32(public::mstate.ebp + -48);
                    this.i16 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i15 = (this.i15 + -1);
                    si32(this.i16, public::mstate.esp);
                    si32(this.i13, (public::mstate.esp + 4));
                    si32(this.i15, (public::mstate.esp + 8));
                    state = 64;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 64:
                    this.i13 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_40: 
                    this.i15 = 4;
                    this.i14 = (this.i14 + this.i12);
                    si32(this.i13, this.i14);
                    this.i13 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i15, (public::mstate.esp + 8));
                    state = 65;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_LoadBlock.start();
                    return;
                case 65:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i14 = li32(public::mstate.ebp + -52);
                    if (!(this.i14 < 0)) goto _label_41;
                    this.i14 = __2E_str156317;
                    this.i15 = li32(this.i11);
                    this.i16 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i17 = __2E_str2158;
                    si32(this.i16, public::mstate.esp);
                    si32(this.i14, (public::mstate.esp + 4));
                    si32(this.i15, (public::mstate.esp + 8));
                    si32(this.i17, (public::mstate.esp + 12));
                    state = 66;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 66:
                    this.i14 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i14 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i15 = 3;
                    si32(this.i14, public::mstate.esp);
                    si32(this.i15, (public::mstate.esp + 4));
                    state = 67;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 67:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i14 = li32(public::mstate.ebp + -52);
                    
                _label_41: 
                    this.i15 = 4;
                    this.i13 = (this.i13 + this.i12);
                    si32(this.i14, (this.i13 + 4));
                    this.i13 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i15, (public::mstate.esp + 8));
                    state = 68;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_LoadBlock.start();
                    return;
                case 68:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i14 = li32(public::mstate.ebp + -56);
                    if (!(this.i14 < 0)) goto _label_42;
                    this.i14 = __2E_str156317;
                    this.i15 = li32(this.i11);
                    this.i16 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i17 = __2E_str2158;
                    si32(this.i16, public::mstate.esp);
                    si32(this.i14, (public::mstate.esp + 4));
                    si32(this.i15, (public::mstate.esp + 8));
                    si32(this.i17, (public::mstate.esp + 12));
                    state = 69;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 69:
                    this.i14 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i14 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i15 = 3;
                    si32(this.i14, public::mstate.esp);
                    si32(this.i15, (public::mstate.esp + 4));
                    state = 70;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 70:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i14 = li32(public::mstate.ebp + -56);
                    
                _label_42: 
                    this.i13 = (this.i13 + this.i12);
                    si32(this.i14, (this.i13 + 8));
                    this.i12 = (this.i12 + 12);
                    this.i9 = (this.i9 + 1);
                    if (this.i9 == this.i1) goto _label_45;
                    goto _label_39;
                    
                _label_43: 
                    this.i7 = __2E_str149;
                    this.i9 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i9, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    state = 71;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 71:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i7 = 0;
                    si32(this.i7, this.i6);
                    si32(this.i1, this.i2);
                    if (this.i1 > 0) goto _label_38;
                    
                _label_44: 
                    if (!(this.i1 < 1))
                    {
                        this.i9 = 0;
                        this.i10 = (public::mstate.ebp + -56);
                        this.i2 = (public::mstate.ebp + -52);
                        this.i7 = (public::mstate.ebp + -48);
                        this.i12 = this.i9;
                        goto _label_39;
                    };
                    
                _label_45: 
                    this.i1 = 4;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (public::mstate.ebp + -60);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 72;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_LoadBlock.start();
                    return;
                case 72:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li32(public::mstate.ebp + -60);
                    if (!(this.i1 < 0)) goto _label_46;
                    this.i1 = __2E_str156317;
                    this.i2 = li32(this.i11);
                    this.i6 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i7 = __2E_str2158;
                    si32(this.i6, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    si32(this.i7, (public::mstate.esp + 12));
                    state = 73;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 73:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i1 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = 3;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 74;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 74:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = li32(public::mstate.ebp + -60);
                    
                _label_46: 
                    this.i2 = (this.i4 + 36);
                    this.i6 = (this.i4 + 28);
                    this.i7 = (this.i1 + 1);
                    if (uint(this.i7) > uint(1073741823)) goto _label_51;
                    this.i7 = 0;
                    this.i9 = li32(this.i3);
                    this.i10 = li32(this.i9 + 16);
                    this.i12 = li32(this.i10 + 12);
                    this.i13 = li32(this.i10 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i14 = (this.i1 << 2);
                    si32(this.i13, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i14, (public::mstate.esp + 12));
                    state = 75;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i12]());
                    return;
                case 75:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i7 == 0)) goto _label_47;
                    if (this.i14 == 0) goto _label_47;
                    this.i12 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i9, public::mstate.esp);
                    si32(this.i12, (public::mstate.esp + 4));
                    state = 76;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 76:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_47: 
                    this.i9 = li32(this.i10 + 68);
                    this.i9 = (this.i14 + this.i9);
                    si32(this.i9, (this.i10 + 68));
                    si32(this.i7, this.i6);
                    si32(this.i1, this.i2);
                    if (this.i1 < 1) goto _label_52;
                    
                _label_48: 
                    this.i2 = 0;
                    this.i7 = this.i2;
                    do 
                    {
                        this.i9 = 0;
                        this.i10 = li32(this.i6);
                        this.i10 = (this.i10 + this.i7);
                        si32(this.i9, this.i10);
                        this.i7 = (this.i7 + 4);
                        this.i2 = (this.i2 + 1);
                        if (this.i2 >= this.i1) goto _label_52;
                    } while (true);
                    
                _label_49: 
                    this.i10 = 4;
                    this.i12 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    state = 77;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_LoadBlock.start();
                    return;
                case 77:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i10 = li32(public::mstate.ebp + -64);
                    if (!(!(this.i10 == 0)))
                    {
                        this.i10 = 0;
                        goto _label_50;
                    };
                    this.i13 = li32(this.i8);
                    this.i14 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i14, public::mstate.esp);
                    si32(this.i13, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    state = 78;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaZ_openspace.start();
                    return;
                case 78:
                    this.i10 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i13 = li32(public::mstate.ebp + -64);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    state = 79;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_LoadBlock.start();
                    return;
                case 79:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i13 = li32(public::mstate.ebp + -64);
                    this.i14 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i13 = (this.i13 + -1);
                    si32(this.i14, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    state = 80;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 80:
                    this.i10 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_50: 
                    this.i12 = (this.i12 + this.i2);
                    si32(this.i10, this.i12);
                    this.i2 = (this.i2 + 4);
                    this.i7 = (this.i7 + 1);
                    if (this.i7 == this.i1) goto _label_53;
                    goto _label_49;
                    
                _label_51: 
                    this.i7 = __2E_str149;
                    this.i9 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i9, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    state = 81;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 81:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i7 = 0;
                    si32(this.i7, this.i6);
                    si32(this.i1, this.i2);
                    if (this.i1 > 0) goto _label_48;
                    
                _label_52: 
                    if (!(this.i1 < 1))
                    {
                        this.i7 = 0;
                        this.i9 = (public::mstate.ebp + -64);
                        this.i2 = this.i7;
                        goto _label_49;
                    };
                    
                _label_53: 
                    this.i0 = 0xFF;
                    this.i1 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_symbexec.start();
                case 82:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(this.i0 == 0)) goto _label_54;
                    this.i0 = __2E_str156317;
                    this.i1 = li32(this.i11);
                    this.i2 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i5 = __2E_str5161;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    state = 83;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 83:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = 3;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 84;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 84:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_54: 
                    this.i0 = li32(this.i3);
                    this.i1 = li32(this.i0 + 8);
                    this.i1 = (this.i1 + -12);
                    si32(this.i1, (this.i0 + 8));
                    this.i0 = li32(this.i3);
                    this.i1 = li16(this.i0 + 52);
                    this.i1 = (this.i1 + -1);
                    si16(this.i1, (this.i0 + 52));
                    public::mstate.eax = this.i4;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _LoadFunction");
            };
        }


    }
}

