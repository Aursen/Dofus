package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_close_func extends Machine 
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
            var _local_1:FSM_close_func;
            _local_1 = new (FSM_close_func)();
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
                    this.i1 = li32(this.i0 + 36);
                    this.i2 = li32(this.i0 + 40);
                    this.i3 = li32(this.i1);
                    this.i4 = li8(this.i1 + 50);
                    this.i5 = (this.i1 + 50);
                    this.i6 = (this.i0 + 36);
                    this.i7 = (this.i0 + 40);
                    this.i8 = this.i1;
                    if (!(this.i4 < 1))
                    {
                        this.i9 = (this.i8 + 24);
                        do 
                        {
                            this.i4 = (this.i4 + -1);
                            this.i10 = li32(this.i1);
                            this.i10 = li32(this.i10 + 24);
                            this.i11 = (this.i4 & 0xFF);
                            this.i11 = (this.i11 << 1);
                            si8(this.i4, this.i5);
                            this.i4 = (this.i8 + this.i11);
                            this.i4 = li16(this.i4 + 172);
                            this.i11 = li32(this.i9);
                            this.i4 = (this.i4 * 12);
                            this.i4 = (this.i10 + this.i4);
                            si32(this.i11, (this.i4 + 8));
                            this.i4 = li8(this.i5);
                        } while (!(this.i4 < 1));
                    };
                    this.i1 = 0x80001E;
                    this.i4 = li32(this.i8 + 12);
                    this.i4 = li32(this.i4 + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i8, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 1:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li32(this.i8 + 24);
                    this.i4 = (this.i8 + 24);
                    this.i5 = (this.i1 + 1);
                    if (uint(this.i5) > uint(1073741823)) goto _label_2;
                    this.i5 = li32(this.i2 + 16);
                    this.i9 = li32(this.i3 + 44);
                    this.i10 = li32(this.i3 + 12);
                    this.i11 = li32(this.i5 + 12);
                    this.i12 = li32(this.i5 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i9 = (this.i9 << 2);
                    this.i1 = (this.i1 << 2);
                    si32(this.i12, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i11]());
                    return;
                case 2:
                    this.i10 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i10 == 0)) goto _label_1;
                    if (this.i1 == 0) goto _label_1;
                    this.i11 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_1: 
                    this.i11 = li32(this.i5 + 68);
                    this.i1 = (this.i1 - this.i9);
                    this.i1 = (this.i1 + this.i11);
                    si32(this.i1, (this.i5 + 68));
                    this.i1 = this.i10;
                    goto _label_3;
                    
                _label_2: 
                    this.i1 = __2E_str149;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = 0;
                    
                _label_3: 
                    si32(this.i1, (this.i3 + 12));
                    this.i1 = li32(this.i4);
                    si32(this.i1, (this.i3 + 44));
                    this.i1 = li32(this.i4);
                    this.i5 = (this.i1 + 1);
                    if (uint(this.i5) > uint(1073741823)) goto _label_5;
                    this.i5 = li32(this.i2 + 16);
                    this.i9 = li32(this.i3 + 48);
                    this.i10 = li32(this.i3 + 20);
                    this.i11 = li32(this.i5 + 12);
                    this.i12 = li32(this.i5 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i9 = (this.i9 << 2);
                    this.i1 = (this.i1 << 2);
                    si32(this.i12, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i11]());
                    return;
                case 5:
                    this.i10 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i10 == 0)) goto _label_4;
                    if (this.i1 == 0) goto _label_4;
                    this.i11 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_4: 
                    this.i11 = li32(this.i5 + 68);
                    this.i1 = (this.i1 - this.i9);
                    this.i1 = (this.i1 + this.i11);
                    si32(this.i1, (this.i5 + 68));
                    this.i1 = this.i10;
                    goto _label_6;
                    
                _label_5: 
                    this.i1 = __2E_str149;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = 0;
                    
                _label_6: 
                    si32(this.i1, (this.i3 + 20));
                    this.i1 = li32(this.i4);
                    si32(this.i1, (this.i3 + 48));
                    this.i1 = li32(this.i8 + 40);
                    this.i4 = (this.i8 + 40);
                    this.i5 = (this.i1 + 1);
                    if (uint(this.i5) > uint(357913941)) goto _label_8;
                    this.i5 = li32(this.i2 + 16);
                    this.i9 = li32(this.i3 + 40);
                    this.i10 = li32(this.i3 + 8);
                    this.i11 = li32(this.i5 + 12);
                    this.i12 = li32(this.i5 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i9 = (this.i9 * 12);
                    this.i1 = (this.i1 * 12);
                    si32(this.i12, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i11]());
                    return;
                case 8:
                    this.i10 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i10 == 0)) goto _label_7;
                    if (this.i1 == 0) goto _label_7;
                    this.i11 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_7: 
                    this.i11 = li32(this.i5 + 68);
                    this.i1 = (this.i1 - this.i9);
                    this.i1 = (this.i1 + this.i11);
                    si32(this.i1, (this.i5 + 68));
                    this.i1 = this.i10;
                    goto _label_9;
                    
                _label_8: 
                    this.i1 = __2E_str149;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 10:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = 0;
                    
                _label_9: 
                    si32(this.i1, (this.i3 + 8));
                    this.i1 = li32(this.i4);
                    si32(this.i1, (this.i3 + 40));
                    this.i1 = li32(this.i8 + 44);
                    this.i4 = (this.i8 + 44);
                    this.i5 = (this.i1 + 1);
                    if (uint(this.i5) > uint(1073741823)) goto _label_11;
                    this.i5 = li32(this.i2 + 16);
                    this.i9 = li32(this.i3 + 52);
                    this.i10 = li32(this.i3 + 16);
                    this.i11 = li32(this.i5 + 12);
                    this.i12 = li32(this.i5 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i9 = (this.i9 << 2);
                    this.i1 = (this.i1 << 2);
                    si32(this.i12, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i11]());
                    return;
                case 11:
                    this.i10 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i10 == 0)) goto _label_10;
                    if (this.i1 == 0) goto _label_10;
                    this.i11 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 12:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_10: 
                    this.i11 = li32(this.i5 + 68);
                    this.i1 = (this.i1 - this.i9);
                    this.i1 = (this.i1 + this.i11);
                    si32(this.i1, (this.i5 + 68));
                    this.i1 = this.i10;
                    goto _label_12;
                    
                _label_11: 
                    this.i1 = __2E_str149;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 13:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = 0;
                    
                _label_12: 
                    si32(this.i1, (this.i3 + 16));
                    this.i1 = li32(this.i4);
                    si32(this.i1, (this.i3 + 52));
                    this.i1 = sxi16(li16(this.i8 + 48));
                    this.i4 = (this.i8 + 48);
                    this.i5 = (this.i1 + 1);
                    if (uint(this.i5) > uint(357913941)) goto _label_14;
                    this.i5 = li32(this.i2 + 16);
                    this.i9 = li32(this.i3 + 56);
                    this.i10 = li32(this.i3 + 24);
                    this.i11 = li32(this.i5 + 12);
                    this.i12 = li32(this.i5 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i9 = (this.i9 * 12);
                    this.i1 = (this.i1 * 12);
                    si32(this.i12, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i11]());
                    return;
                case 14:
                    this.i10 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i10 == 0)) goto _label_13;
                    if (this.i1 == 0) goto _label_13;
                    this.i11 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 15:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_13: 
                    this.i11 = li32(this.i5 + 68);
                    this.i1 = (this.i1 - this.i9);
                    this.i1 = (this.i1 + this.i11);
                    si32(this.i1, (this.i5 + 68));
                    this.i1 = this.i10;
                    goto _label_15;
                    
                _label_14: 
                    this.i1 = __2E_str149;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 16:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = 0;
                    
                _label_15: 
                    si32(this.i1, (this.i3 + 24));
                    this.i1 = sxi16(li16(this.i4));
                    si32(this.i1, (this.i3 + 56));
                    this.i1 = li32(this.i2 + 16);
                    this.i4 = li8(this.i3 + 72);
                    this.i5 = li32(this.i3 + 36);
                    this.i9 = li32(this.i3 + 28);
                    this.i10 = li32(this.i1 + 12);
                    this.i11 = li32(this.i1 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i5 = (this.i5 << 2);
                    this.i4 = (this.i4 << 2);
                    si32(this.i11, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i10]());
                    return;
                case 17:
                    this.i9 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i10 = (this.i3 + 28);
                    this.i11 = (this.i3 + 36);
                    this.i3 = (this.i3 + 72);
                    if (!(this.i9 == 0)) goto _label_16;
                    if (this.i4 == 0) goto _label_16;
                    this.i12 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i12, (public::mstate.esp + 4));
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 18:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_16: 
                    this.i12 = li32(this.i1 + 68);
                    this.i4 = (this.i4 - this.i5);
                    this.i4 = (this.i4 + this.i12);
                    si32(this.i4, (this.i1 + 68));
                    si32(this.i9, this.i10);
                    this.i1 = li8(this.i3);
                    si32(this.i1, this.i11);
                    this.i1 = li32(this.i8 + 8);
                    si32(this.i1, this.i6);
                    this.i1 = li32(this.i2 + 8);
                    this.i1 = (this.i1 + -24);
                    si32(this.i1, (this.i2 + 8));
                    if (this.i8 == 0) goto _label_18;
                    this.i1 = li32(this.i0 + 12);
                    this.i1 = (this.i1 + -285);
                    if (uint(this.i1) > uint(1)) goto _label_18;
                    this.i0 = li32(this.i0 + 16);
                    this.i1 = li32(this.i0 + 12);
                    this.i2 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = (this.i0 + 16);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 19:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li32(this.i6);
                    this.i1 = li32(this.i1 + 4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_setstr.start();
                    return;
                case 20:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li32(this.i0 + 8);
                    this.i2 = (this.i0 + 8);
                    if (!(!(this.i1 == 0)))
                    {
                        this.i1 = 1;
                        si32(this.i1, this.i0);
                        si32(this.i1, this.i2);
                    };
                    
                _label_17: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_18: 
                    goto _label_17;
                default:
                    throw ("Invalid state in _close_func");
            };
        }


    }
}

