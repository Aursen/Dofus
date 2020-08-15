package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_f_luaopen391 extends Machine 
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
            var _local_1:FSM_f_luaopen391;
            _local_1 = new (FSM_f_luaopen391)();
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
                    this.i0 = 32;
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = li32(this.i1 + 16);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_stack_init.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i1 + 16);
                    this.i4 = li32(this.i3 + 12);
                    this.i5 = li32(this.i3 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i6 = 0;
                    si32(this.i5, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i4]());
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i4 = (this.i1 + 72);
                    this.i5 = (this.i1 + 16);
                    if (!(this.i0 == 0)) goto _label_1;
                    this.i6 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_1: 
                    this.i6 = 5;
                    this.i7 = li32(this.i3 + 68);
                    this.i7 = (this.i7 + 32);
                    si32(this.i7, (this.i3 + 68));
                    this.i3 = li32(this.i5);
                    this.i7 = li32(this.i3 + 28);
                    si32(this.i7, this.i0);
                    si32(this.i0, (this.i3 + 28));
                    this.i3 = li8(this.i3 + 20);
                    this.i3 = (this.i3 & 0x03);
                    si8(this.i3, (this.i0 + 5));
                    si8(this.i6, (this.i0 + 4));
                    this.i3 = 0;
                    si32(this.i3, (this.i0 + 8));
                    this.i6 = -1;
                    si8(this.i6, (this.i0 + 6));
                    si32(this.i3, (this.i0 + 12));
                    si32(this.i3, (this.i0 + 28));
                    si8(this.i3, (this.i0 + 7));
                    this.i6 = _dummynode_;
                    si32(this.i6, (this.i0 + 16));
                    this.i6 = li32(this.i5);
                    this.i7 = li32(this.i6 + 12);
                    this.i6 = li32(this.i6 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i7]());
                    return;
                case 4:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    si32(this.i3, (this.i0 + 12));
                    this.i3 = li32(this.i0 + 28);
                    this.i6 = (this.i0 + 28);
                    this.i7 = (this.i0 + 12);
                    this.i8 = this.i0;
                    if (!(this.i3 > -1))
                    {
                        this.i9 = (this.i3 * 12);
                        this.i9 = (this.i9 + 8);
                        do 
                        {
                            this.i10 = 0;
                            this.i11 = li32(this.i7);
                            this.i11 = (this.i11 + this.i9);
                            si32(this.i10, this.i11);
                            this.i9 = (this.i9 + 12);
                            this.i3 = (this.i3 + 1);
                        } while (!(this.i3 > -1));
                    };
                    this.i3 = 0;
                    si32(this.i3, this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = 2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_setnodevector.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i8, this.i4);
                    this.i0 = 5;
                    si32(this.i0, (this.i1 + 80));
                    this.i0 = li32(this.i5);
                    this.i4 = li32(this.i0 + 12);
                    this.i6 = li32(this.i0 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i7 = 32;
                    si32(this.i6, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i7, (public::mstate.esp + 12));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i4]());
                    return;
                case 6:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i4 = (this.i0 + 92);
                    if (!(this.i3 == 0)) goto _label_2;
                    this.i6 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_2: 
                    this.i6 = 5;
                    this.i7 = li32(this.i0 + 68);
                    this.i7 = (this.i7 + 32);
                    si32(this.i7, (this.i0 + 68));
                    this.i7 = li32(this.i5);
                    this.i8 = li32(this.i7 + 28);
                    si32(this.i8, this.i3);
                    si32(this.i3, (this.i7 + 28));
                    this.i7 = li8(this.i7 + 20);
                    this.i7 = (this.i7 & 0x03);
                    si8(this.i7, (this.i3 + 5));
                    si8(this.i6, (this.i3 + 4));
                    this.i6 = 0;
                    si32(this.i6, (this.i3 + 8));
                    this.i7 = -1;
                    si8(this.i7, (this.i3 + 6));
                    si32(this.i6, (this.i3 + 12));
                    si32(this.i6, (this.i3 + 28));
                    si8(this.i6, (this.i3 + 7));
                    this.i7 = _dummynode_;
                    si32(this.i7, (this.i3 + 16));
                    this.i7 = li32(this.i5);
                    this.i8 = li32(this.i7 + 12);
                    this.i7 = li32(this.i7 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i6, (public::mstate.esp + 12));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i8]());
                    return;
                case 8:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    si32(this.i6, (this.i3 + 12));
                    this.i6 = li32(this.i3 + 28);
                    this.i7 = (this.i3 + 28);
                    this.i8 = (this.i3 + 12);
                    this.i9 = this.i3;
                    if (!(this.i6 > -1))
                    {
                        this.i10 = (this.i6 * 12);
                        this.i10 = (this.i10 + 8);
                        do 
                        {
                            this.i11 = 0;
                            this.i12 = li32(this.i8);
                            this.i12 = (this.i12 + this.i10);
                            si32(this.i11, this.i12);
                            this.i10 = (this.i10 + 12);
                            this.i6 = (this.i6 + 1);
                        } while (!(this.i6 > -1));
                    };
                    this.i6 = 0;
                    si32(this.i6, this.i7);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_setnodevector.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i9, this.i4);
                    this.i3 = 5;
                    si32(this.i3, (this.i0 + 100));
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = 32;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_resize.start();
                    return;
                case 10:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = _luaT_eventname_2E_2633;
                    this.i3 = this.i6;
                    this.i4 = this.i6;
                    
                _label_3: 
                    this.i6 = (this.i0 + this.i3);
                    this.i6 = li32(this.i6);
                    this.i7 = li32(this.i5);
                    this.i8 = li8(this.i6);
                    this.i9 = this.i6;
                    if (this.i8 == 0) goto _label_7;
                    this.i8 = this.i6;
                    do 
                    {
                        this.i10 = li8(this.i8 + 1);
                        this.i8 = (this.i8 + 1);
                        this.i11 = this.i8;
                        if (this.i10 == 0) goto _label_8;
                        this.i8 = this.i11;
                    } while (true);
                    
                _label_4: 
                    this.i0 = _luaX_tokens;
                    this.i3 = 0;
                    this.i4 = 1;
                    
                _label_5: 
                    this.i5 = li32(this.i0);
                    this.i6 = li8(this.i5);
                    this.i7 = this.i5;
                    if (this.i6 == 0) goto _label_9;
                    this.i6 = this.i5;
                    do 
                    {
                        this.i8 = li8(this.i6 + 1);
                        this.i6 = (this.i6 + 1);
                        this.i9 = this.i6;
                        if (this.i8 == 0) goto _label_10;
                        this.i6 = this.i9;
                    } while (true);
                    
                _label_6: 
                    this.i0 = __2E_str111;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = 17;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 11:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li8(this.i0 + 5);
                    this.i1 = (this.i1 | 0x20);
                    si8(this.i1, (this.i0 + 5));
                    this.i0 = li32(this.i2 + 68);
                    this.i0 = (this.i0 << 2);
                    si32(this.i0, (this.i2 + 64));
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_7: 
                    this.i8 = this.i9;
                    
                _label_8: 
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = (this.i8 - this.i6);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 12:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i7 = (this.i7 + this.i3);
                    si32(this.i6, (this.i7 + 168));
                    this.i6 = li32(this.i5);
                    this.i6 = (this.i6 + this.i3);
                    this.i6 = li32(this.i6 + 168);
                    this.i7 = li8(this.i6 + 5);
                    this.i7 = (this.i7 | 0x20);
                    si8(this.i7, (this.i6 + 5));
                    this.i3 = (this.i3 + 4);
                    this.i4 = (this.i4 + 1);
                    if (this.i4 == 17) goto _label_4;
                    goto _label_3;
                    
                _label_9: 
                    this.i6 = this.i7;
                    
                _label_10: 
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = (this.i6 - this.i5);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 13:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i6 = li8(this.i5 + 5);
                    this.i6 = (this.i6 | 0x20);
                    si8(this.i6, (this.i5 + 5));
                    si8(this.i4, (this.i5 + 6));
                    this.i4 = (this.i4 + 1);
                    this.i0 = (this.i0 + 4);
                    this.i3 = (this.i3 + 1);
                    if (this.i3 == 21) goto _label_6;
                    goto _label_5;
                default:
                    throw ("Invalid state in _f_luaopen391");
            };
        }


    }
}

