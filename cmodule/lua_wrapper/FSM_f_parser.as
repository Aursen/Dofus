package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_f_parser extends Machine 
    {

        public static const intRegCount:int = 11;
        public static const NumberRegCount:int = 0;

        public var i10:int;
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
            var _local_1:FSM_f_parser;
            _local_1 = new (FSM_f_parser)();
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
                    this.i0 = li32(public::mstate.ebp + 12);
                    this.i1 = li32(this.i0);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaZ_lookahead.start();
                    return;
                case 1:
                    this.i1 = public::mstate.eax;
                    this.i2 = li32(public::mstate.ebp + 8);
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i3 = li32(this.i2 + 16);
                    this.i4 = li32(this.i3 + 68);
                    this.i3 = li32(this.i3 + 64);
                    this.i5 = (this.i2 + 16);
                    this.i6 = this.i0;
                    if (uint(this.i4) < uint(this.i3)) goto _label_1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_1: 
                    this.i3 = _luaU_undump;
                    this.i4 = li32(this.i6 + 16);
                    this.i0 = li32(this.i0);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i6 = (this.i6 + 4);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    this.i0 = _luaY_parser;
                    this.i0 = ((this.i1 == 27) ? this.i3 : this.i0);
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i0]());
                    return;
                case 3:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i1 = li32(this.i2 + 72);
                    this.i3 = li8(this.i0 + 72);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaF_newLclosure.start();
                    return;
                case 4:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, (this.i1 + 16));
                    this.i3 = li8(this.i0 + 72);
                    this.i0 = (this.i0 + 72);
                    this.i4 = this.i1;
                    if (this.i3 < 1) goto _label_4;
                    this.i3 = 0;
                    this.i4 = (this.i4 + 20);
                    
                _label_2: 
                    this.i6 = 24;
                    this.i7 = li32(this.i5);
                    this.i8 = li32(this.i7 + 12);
                    this.i9 = li32(this.i7 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i10 = 0;
                    si32(this.i9, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    si32(this.i6, (public::mstate.esp + 12));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i8]());
                    return;
                case 5:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i8 = this.i4;
                    if (!(this.i6 == 0)) goto _label_3;
                    this.i9 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_3: 
                    this.i9 = 10;
                    this.i10 = li32(this.i7 + 68);
                    this.i10 = (this.i10 + 24);
                    si32(this.i10, (this.i7 + 68));
                    this.i7 = li32(this.i5);
                    this.i10 = li32(this.i7 + 28);
                    si32(this.i10, this.i6);
                    si32(this.i6, (this.i7 + 28));
                    this.i7 = li8(this.i7 + 20);
                    this.i7 = (this.i7 & 0x03);
                    si8(this.i7, (this.i6 + 5));
                    si8(this.i9, (this.i6 + 4));
                    this.i7 = (this.i6 + 12);
                    si32(this.i7, (this.i6 + 8));
                    this.i7 = 0;
                    si32(this.i7, (this.i6 + 20));
                    si32(this.i6, this.i8);
                    this.i6 = li8(this.i0);
                    this.i4 = (this.i4 + 4);
                    this.i3 = (this.i3 + 1);
                    if (!(this.i6 <= this.i3)) goto _label_2;
                    
                _label_4: 
                    this.i0 = 6;
                    this.i3 = li32(this.i2 + 8);
                    si32(this.i1, this.i3);
                    si32(this.i0, (this.i3 + 8));
                    this.i0 = li32(this.i2 + 28);
                    this.i1 = li32(this.i2 + 8);
                    this.i3 = (this.i2 + 8);
                    this.i0 = (this.i0 - this.i1);
                    if (this.i0 > 12) goto _label_7;
                    this.i1 = li32(this.i2 + 44);
                    if (this.i1 < 1) goto _label_5;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = (this.i1 << 1);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_6;
                    
                _label_5: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = (this.i1 + 1);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_6: 
                    this.i1 = li32(this.i3);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i3);
                    goto _label_8;
                    
                _label_7: 
                    this.i0 = (this.i1 + 12);
                    si32(this.i0, this.i3);
                    
                _label_8: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _f_parser");
            };
        }


    }
} cmodule.lua_wrapper

