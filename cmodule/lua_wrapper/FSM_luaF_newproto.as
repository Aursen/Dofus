package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaF_newproto extends Machine 
    {

        public static const intRegCount:int = 6;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;


        public static function start():void
        {
            var _local_1:FSM_luaF_newproto;
            _local_1 = new (FSM_luaF_newproto)();
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
                    this.i0 = 76;
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = li32(this.i1 + 16);
                    this.i3 = li32(this.i2 + 12);
                    this.i4 = li32(this.i2 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i5 = 0;
                    si32(this.i4, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i3]());
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i3 = (this.i1 + 16);
                    if (!(this.i0 == 0)) goto _label_1;
                    this.i4 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_1: 
                    this.i1 = 9;
                    this.i4 = li32(this.i2 + 68);
                    this.i4 = (this.i4 + 76);
                    si32(this.i4, (this.i2 + 68));
                    this.i2 = li32(this.i3);
                    this.i3 = li32(this.i2 + 28);
                    si32(this.i3, this.i0);
                    si32(this.i0, (this.i2 + 28));
                    this.i2 = li8(this.i2 + 20);
                    this.i2 = (this.i2 & 0x03);
                    si8(this.i2, (this.i0 + 5));
                    si8(this.i1, (this.i0 + 4));
                    this.i1 = 0;
                    si32(this.i1, (this.i0 + 8));
                    si32(this.i1, (this.i0 + 40));
                    si32(this.i1, (this.i0 + 16));
                    si32(this.i1, (this.i0 + 52));
                    si32(this.i1, (this.i0 + 12));
                    si32(this.i1, (this.i0 + 44));
                    si32(this.i1, (this.i0 + 48));
                    si32(this.i1, (this.i0 + 36));
                    si8(this.i1, (this.i0 + 72));
                    si32(this.i1, (this.i0 + 28));
                    si8(this.i1, (this.i0 + 73));
                    si8(this.i1, (this.i0 + 74));
                    si8(this.i1, (this.i0 + 75));
                    si32(this.i1, (this.i0 + 20));
                    si32(this.i1, (this.i0 + 56));
                    si32(this.i1, (this.i0 + 24));
                    si32(this.i1, (this.i0 + 60));
                    si32(this.i1, (this.i0 + 64));
                    si32(this.i1, (this.i0 + 32));
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _luaF_newproto");
            };
        }


    }
}

