package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_lua_pushcclosure extends Machine 
    {

        public static const intRegCount:int = 10;
        public static const NumberRegCount:int = 1;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i8:int;
        public var f0:Number;
        public var i7:int;
        public var i9:int;


        public static function start():void
        {
            var _local_1:FSM_lua_pushcclosure;
            _local_1 = new (FSM_lua_pushcclosure)();
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
                    this.i2 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    this.i3 = li32(public::mstate.ebp + 12);
                    this.i4 = li32(public::mstate.ebp + 16);
                    this.i5 = (this.i0 + 16);
                    if (uint(this.i2) < uint(this.i1)) goto _label_1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_1: 
                    this.i1 = li32(this.i0 + 20);
                    this.i2 = li32(this.i0 + 40);
                    if (!(!(this.i1 == this.i2)))
                    {
                        this.i1 = li32(this.i0 + 72);
                    }
                    else
                    {
                        this.i1 = li32(this.i1 + 4);
                        this.i1 = li32(this.i1);
                        this.i1 = li32(this.i1 + 12);
                    };
                    this.i2 = 0;
                    this.i6 = li32(this.i5);
                    this.i7 = li32(this.i6 + 12);
                    this.i8 = li32(this.i6 + 16);
                    this.i9 = (this.i4 * 12);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i9 = (this.i9 + 20);
                    si32(this.i8, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    si32(this.i9, (public::mstate.esp + 12));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i7]());
                    return;
                case 2:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i2 == 0)) goto _label_2;
                    if (this.i9 == 0) goto _label_2;
                    this.i7 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_2: 
                    this.i7 = 6;
                    this.i8 = li32(this.i6 + 68);
                    this.i8 = (this.i9 + this.i8);
                    si32(this.i8, (this.i6 + 68));
                    this.i5 = li32(this.i5);
                    this.i6 = li32(this.i5 + 28);
                    si32(this.i6, this.i2);
                    si32(this.i2, (this.i5 + 28));
                    this.i5 = li8(this.i5 + 20);
                    this.i5 = (this.i5 & 0x03);
                    si8(this.i5, (this.i2 + 5));
                    si8(this.i7, (this.i2 + 4));
                    this.i5 = 1;
                    si8(this.i5, (this.i2 + 6));
                    si32(this.i1, (this.i2 + 12));
                    si8(this.i4, (this.i2 + 7));
                    this.i1 = (0 - this.i4);
                    si32(this.i3, (this.i2 + 16));
                    this.i3 = li32(this.i0 + 8);
                    this.i1 = (this.i1 * 12);
                    this.i1 = (this.i3 + this.i1);
                    si32(this.i1, (this.i0 + 8));
                    this.i0 = (this.i0 + 8);
                    this.i3 = this.i2;
                    if (!(!(this.i4 == 0)))
                    {
                        
                    _label_3: 
                        this.i2 = 6;
                        si32(this.i3, this.i1);
                        si32(this.i2, (this.i1 + 8));
                        this.i1 = li32(this.i0);
                        this.i1 = (this.i1 + 12);
                        si32(this.i1, this.i0);
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                    };
                    this.i5 = 0;
                    this.i6 = (this.i4 * 12);
                    do 
                    {
                        this.i1 = (this.i1 + this.i6);
                        this.f0 = lf64(this.i1 + -12);
                        this.i7 = (this.i2 + this.i6);
                        sf64(this.f0, (this.i7 + 8));
                        this.i1 = li32(this.i1 + -4);
                        si32(this.i1, (this.i7 + 16));
                        this.i1 = li32(this.i0);
                        this.i6 = (this.i6 + -12);
                        this.i5 = (this.i5 + 1);
                        if (this.i5 == this.i4) goto _label_3;
                    } while (true);
                default:
                    throw ("Invalid state in _lua_pushcclosure");
            };
        }


    }
}

