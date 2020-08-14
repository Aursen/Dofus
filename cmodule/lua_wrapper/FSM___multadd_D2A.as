package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___multadd_D2A extends Machine 
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
            var _local_1:FSM___multadd_D2A;
            _local_1 = new (FSM___multadd_D2A)();
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
                    this.i2 = li32(public::mstate.ebp + 16);
                    this.i3 = li32(public::mstate.ebp + 12);
                    this.i4 = li32(this.i1 + 16);
                    this.i5 = (this.i3 >> 31);
                    this.i6 = (this.i2 >> 31);
                    this.i7 = (this.i1 + 20);
                    this.i8 = (this.i1 + 16);
                    
                _label_1: 
                    this.i9 = 0;
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i10 = li32(this.i7);
                    si32(this.i10, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[___muldi3]());
                case 1:
                    this.i10 = public::mstate.eax;
                    this.i11 = public::mstate.edx;
                    this.i2 = __addc(this.i10, this.i2);
                    this.i6 = __adde(this.i11, this.i6);
                    si32(this.i2, this.i7);
                    this.i2 = (this.i7 + 4);
                    this.i0 = (this.i0 + 1);
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i7 = this.i6;
                    if (!(this.i0 >= this.i4))
                    {
                        this.i7 = this.i2;
                        this.i2 = this.i6;
                        this.i6 = this.i9;
                        goto _label_1;
                    };
                    this.i0 = ((this.i7 == 0) ? 1 : 0);
                    if (!(this.i0 == 0)) goto _label_3;
                    this.i0 = li32(this.i1 + 8);
                    if (!(this.i0 <= this.i4)) goto _label_2;
                    this.i0 = li32(this.i1 + 4);
                    public::mstate.esp = (public::mstate.esp - 4);
                    this.i0 = (this.i0 + 1);
                    si32(this.i0, public::mstate.esp);
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___Balloc_D2A.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i2 = li32(this.i8);
                    this.i3 = (this.i0 + 12);
                    this.i2 = (this.i2 << 2);
                    this.i5 = (this.i1 + 12);
                    this.i2 = (this.i2 + 8);
                    memcpy(this.i3, this.i5, this.i2);
                    this.i2 = (this.i1 + 4);
                    if (!(!(this.i1 == 0)))
                    {
                        this.i1 = this.i0;
                    }
                    else
                    {
                        this.i3 = _freelist;
                        this.i2 = li32(this.i2);
                        this.i2 = (this.i2 << 2);
                        this.i2 = (this.i3 + this.i2);
                        this.i3 = li32(this.i2);
                        si32(this.i3, this.i1);
                        si32(this.i1, this.i2);
                        this.i1 = this.i0;
                    };
                    
                _label_2: 
                    this.i0 = (this.i4 << 2);
                    this.i0 = (this.i1 + this.i0);
                    si32(this.i6, (this.i0 + 20));
                    this.i0 = (this.i4 + 1);
                    si32(this.i0, (this.i1 + 16));
                    
                _label_3: 
                    public::mstate.eax = this.i1;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in ___multadd_D2A");
            };
        }


    }
} cmodule.lua_wrapper

