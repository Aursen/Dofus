package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaD_callhook extends Machine 
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
            var _local_1:FSM_luaD_callhook;
            _local_1 = new (FSM_luaD_callhook)();
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
                    public::mstate.esp = (public::mstate.esp - 112);
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li32(this.i0 + 68);
                    this.i2 = li32(public::mstate.ebp + 12);
                    this.i3 = li32(public::mstate.ebp + 16);
                    if (this.i1 == 0) goto _label_3;
                    this.i4 = li8(this.i0 + 57);
                    this.i5 = (this.i0 + 57);
                    if (this.i4 == 0) goto _label_3;
                    this.i4 = li32(this.i0 + 20);
                    this.i6 = li32(this.i0 + 8);
                    this.i7 = li32(this.i0 + 32);
                    this.i8 = li32(this.i4 + 8);
                    si32(this.i2, (public::mstate.ebp + -112));
                    si32(this.i3, (public::mstate.ebp + -92));
                    this.i3 = (this.i8 - this.i7);
                    this.i8 = (this.i0 + 20);
                    this.i7 = (this.i6 - this.i7);
                    this.i9 = (this.i0 + 32);
                    this.i10 = (this.i0 + 8);
                    if (!(!(this.i2 == 4)))
                    {
                        this.i4 = 0;
                        si32(this.i4, (public::mstate.ebp + -16));
                    }
                    else
                    {
                        this.i2 = li32(this.i0 + 40);
                        this.i2 = (this.i4 - this.i2);
                        this.i2 = (this.i2 / 24);
                        si32(this.i2, (public::mstate.ebp + -16));
                    };
                    this.i2 = li32(this.i0 + 28);
                    this.i2 = (this.i2 - this.i6);
                    if (this.i2 > 240) goto _label_2;
                    this.i2 = li32(this.i0 + 44);
                    if (this.i2 < 20) goto _label_1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = (this.i2 << 1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_2;
                    
                _label_1: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = (this.i2 + 20);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_2: 
                    this.i2 = 0;
                    this.i4 = li32(this.i10);
                    this.i6 = li32(this.i8);
                    this.i4 = (this.i4 + 240);
                    si32(this.i4, (this.i6 + 8));
                    si8(this.i2, this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = (public::mstate.ebp + -112);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i1]());
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = 1;
                    si8(this.i0, this.i5);
                    this.i0 = li32(this.i8);
                    this.i1 = li32(this.i9);
                    this.i1 = (this.i1 + this.i3);
                    si32(this.i1, (this.i0 + 8));
                    this.i0 = li32(this.i9);
                    this.i0 = (this.i0 + this.i7);
                    si32(this.i0, this.i10);
                    
                _label_3: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _luaD_callhook");
            };
        }


    }
}

