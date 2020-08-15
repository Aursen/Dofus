package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_lua_newuserdata extends Machine 
    {

        public static const intRegCount:int = 9;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i8:int;
        public var i7:int;


        public static function start():void
        {
            var _local_1:FSM_lua_newuserdata;
            _local_1 = new (FSM_lua_newuserdata)();
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
                    this.i4 = (this.i0 + 16);
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
                    if (uint(this.i3) < uint(-22)) goto _label_2;
                    this.i2 = __2E_str149;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_2: 
                    this.i2 = 0;
                    this.i5 = li32(this.i4);
                    this.i6 = li32(this.i5 + 12);
                    this.i7 = li32(this.i5 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i8 = (this.i3 + 20);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    si32(this.i8, (public::mstate.esp + 12));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i6]());
                    return;
                case 3:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i2 == 0)) goto _label_3;
                    if (this.i8 == 0) goto _label_3;
                    this.i6 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_3: 
                    this.i6 = 7;
                    this.i7 = li32(this.i5 + 68);
                    this.i7 = (this.i8 + this.i7);
                    si32(this.i7, (this.i5 + 68));
                    this.i5 = li32(this.i4);
                    this.i5 = li8(this.i5 + 20);
                    this.i5 = (this.i5 & 0x03);
                    si8(this.i5, (this.i2 + 5));
                    si8(this.i6, (this.i2 + 4));
                    si32(this.i3, (this.i2 + 16));
                    this.i3 = 0;
                    si32(this.i3, (this.i2 + 8));
                    si32(this.i1, (this.i2 + 12));
                    this.i1 = li32(this.i4);
                    this.i1 = li32(this.i1 + 104);
                    this.i1 = li32(this.i1);
                    si32(this.i1, this.i2);
                    this.i1 = li32(this.i4);
                    this.i1 = li32(this.i1 + 104);
                    si32(this.i2, this.i1);
                    this.i1 = li32(this.i0 + 8);
                    si32(this.i2, this.i1);
                    si32(this.i6, (this.i1 + 8));
                    this.i1 = li32(this.i0 + 8);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, (this.i0 + 8));
                    this.i0 = (this.i2 + 20);
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _lua_newuserdata");
            };
        }


    }
}

