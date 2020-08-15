package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaF_newLclosure extends Machine 
    {

        public static const intRegCount:int = 8;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i7:int;


        public static function start():void
        {
            var _local_1:FSM_luaF_newLclosure;
            _local_1 = new (FSM_luaF_newLclosure)();
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
                    this.i0 = 0;
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = li32(this.i1 + 16);
                    this.i3 = li32(public::mstate.ebp + 12);
                    this.i4 = li32(this.i2 + 12);
                    this.i5 = li32(this.i2 + 16);
                    this.i6 = (this.i3 << 2);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i6 = (this.i6 + 20);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    si32(this.i6, (public::mstate.esp + 12));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i4]());
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i4 = (this.i1 + 16);
                    this.i5 = li32(public::mstate.ebp + 16);
                    if (!(this.i0 == 0)) goto _label_1;
                    if (this.i6 == 0) goto _label_1;
                    this.i7 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_1: 
                    this.i1 = 6;
                    this.i7 = li32(this.i2 + 68);
                    this.i6 = (this.i6 + this.i7);
                    si32(this.i6, (this.i2 + 68));
                    this.i2 = li32(this.i4);
                    this.i4 = li32(this.i2 + 28);
                    si32(this.i4, this.i0);
                    si32(this.i0, (this.i2 + 28));
                    this.i2 = li8(this.i2 + 20);
                    this.i2 = (this.i2 & 0x03);
                    si8(this.i2, (this.i0 + 5));
                    si8(this.i1, (this.i0 + 4));
                    this.i1 = 0;
                    si8(this.i1, (this.i0 + 6));
                    si32(this.i5, (this.i0 + 12));
                    si8(this.i3, (this.i0 + 7));
                    this.i1 = this.i0;
                    if (!(this.i3 == 0))
                    {
                        this.i2 = 0;
                        this.i4 = (this.i3 << 2);
                        this.i1 = (this.i1 + this.i4);
                        this.i1 = (this.i1 + 16);
                        do 
                        {
                            this.i4 = 0;
                            si32(this.i4, this.i1);
                            this.i1 = (this.i1 + -4);
                            this.i2 = (this.i2 + 1);
                        } while (!(this.i2 == this.i3));
                    };
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _luaF_newLclosure");
            };
        }


    }
}

