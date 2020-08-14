package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_save extends Machine 
    {

        public static const intRegCount:int = 12;
        public static const NumberRegCount:int = 0;

        public var i10:int;
        public var i11:int;
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
            var _local_1:FSM_save;
            _local_1 = new (FSM_save)();
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
                    public::mstate.esp = (public::mstate.esp - 80);
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li32(this.i0 + 48);
                    this.i2 = li32(this.i1 + 4);
                    this.i3 = li32(this.i1 + 8);
                    this.i4 = (this.i1 + 8);
                    this.i5 = (this.i1 + 4);
                    this.i6 = li32(public::mstate.ebp + 12);
                    this.i2 = (this.i2 + 1);
                    if (uint(this.i2) <= uint(this.i3)) goto _label_4;
                    if (uint(this.i3) < uint(2147483646)) goto _label_1;
                    this.i2 = 80;
                    this.i3 = li32(this.i0 + 52);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = (public::mstate.ebp + -80);
                    this.i3 = (this.i3 + 16);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_chunkid.start();
                case 1:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i2 = li32(this.i0 + 4);
                    this.i3 = li32(this.i0 + 40);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i8 = __2E_str15272;
                    this.i9 = __2E_str36293;
                    si32(this.i3, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    si32(this.i9, (public::mstate.esp + 16));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 2:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i2 = li32(this.i0 + 40);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = 3;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_1: 
                    this.i2 = li32(this.i4);
                    this.i3 = (this.i2 << 1);
                    this.i7 = this.i1;
                    this.i8 = (this.i3 | 0x01);
                    if (uint(this.i8) > uint(-3)) goto _label_3;
                    this.i0 = li32(this.i0 + 40);
                    this.i8 = li32(this.i0 + 16);
                    this.i9 = li32(this.i7);
                    this.i10 = li32(this.i8 + 12);
                    this.i11 = li32(this.i8 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i11, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i10]());
                    return;
                case 4:
                    this.i9 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i9 == 0)) goto _label_2;
                    if (this.i3 == 0) goto _label_2;
                    this.i10 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_2: 
                    this.i0 = li32(this.i8 + 68);
                    this.i2 = (this.i3 - this.i2);
                    this.i0 = (this.i2 + this.i0);
                    si32(this.i0, (this.i8 + 68));
                    si32(this.i9, this.i7);
                    si32(this.i3, this.i4);
                    goto _label_4;
                    
                _label_3: 
                    this.i2 = __2E_str149;
                    this.i0 = li32(this.i0 + 40);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = 0;
                    si32(this.i0, this.i7);
                    si32(this.i3, this.i4);
                    
                _label_4: 
                    this.i0 = li32(this.i5);
                    this.i1 = li32(this.i1);
                    this.i1 = (this.i1 + this.i0);
                    si8(this.i6, this.i1);
                    this.i0 = (this.i0 + 1);
                    si32(this.i0, this.i5);
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _save");
            };
        }


    }
} cmodule.lua_wrapper

