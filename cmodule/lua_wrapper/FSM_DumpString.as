package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_DumpString extends Machine 
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
            var _local_1:FSM_DumpString;
            _local_1 = new (FSM_DumpString)();
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
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li32(public::mstate.ebp + 12);
                    if (!(this.i0 == 0))
                    {
                        this.i2 = (this.i0 + 16);
                        if (!(this.i2 == 0)) goto _label_2;
                    };
                    this.i0 = 0;
                    si32(this.i0, (public::mstate.ebp + -4));
                    this.i0 = li32(this.i1 + 16);
                    this.i2 = (this.i1 + 16);
                    if (!(this.i0 == 0)) goto _label_1;
                    this.i0 = 4;
                    this.i3 = li32(this.i1 + 4);
                    this.i4 = li32(this.i1 + 8);
                    this.i1 = li32(this.i1);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i5 = (public::mstate.ebp + -4);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i3]());
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    si32(this.i0, this.i2);
                    
                _label_1: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_2: 
                    this.i0 = li32(this.i0 + 12);
                    this.i0 = (this.i0 + 1);
                    si32(this.i0, (public::mstate.ebp + -8));
                    this.i0 = li32(this.i1 + 16);
                    this.i3 = (this.i1 + 16);
                    if (!(this.i0 == 0)) goto _label_3;
                    this.i0 = 4;
                    this.i4 = li32(this.i1 + 4);
                    this.i5 = li32(this.i1 + 8);
                    this.i6 = li32(this.i1);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i7 = (public::mstate.ebp + -8);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i4]());
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    si32(this.i0, this.i3);
                    
                _label_3: 
                    if (!(this.i0 == 0)) goto _label_4;
                    this.i0 = li32(public::mstate.ebp + -8);
                    this.i4 = li32(this.i1 + 4);
                    this.i5 = li32(this.i1 + 8);
                    this.i1 = li32(this.i1);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i4]());
                    return;
                case 3:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    si32(this.i0, this.i3);
                    
                _label_4: 
                    goto _label_1;
                default:
                    throw ("Invalid state in _DumpString");
            };
        }


    }
}

