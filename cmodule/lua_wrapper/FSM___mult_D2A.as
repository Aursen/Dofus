package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___mult_D2A extends Machine 
    {

        public static const intRegCount:int = 21;
        public static const NumberRegCount:int = 0;

        public var i10:int;
        public var i11:int;
        public var i12:int;
        public var i13:int;
        public var i14:int;
        public var i15:int;
        public var i17:int;
        public var i19:int;
        public var i16:int;
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
        public var i18:int;
        public var i20:int;


        public static function start():void
        {
            var _local_1:FSM___mult_D2A;
            _local_1 = new (FSM___mult_D2A)();
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
                    this.i1 = li32(public::mstate.ebp + 12);
                    this.i2 = li32(this.i0 + 16);
                    this.i3 = li32(this.i1 + 16);
                    this.i4 = ((this.i2 < this.i3) ? this.i0 : this.i1);
                    this.i0 = ((this.i2 < this.i3) ? this.i1 : this.i0);
                    this.i1 = li32(this.i0 + 16);
                    this.i2 = li32(this.i4 + 16);
                    this.i3 = li32(this.i0 + 8);
                    this.i5 = (this.i2 + this.i1);
                    this.i6 = li32(this.i0 + 4);
                    this.i3 = ((this.i3 < this.i5) ? 1 : 0);
                    this.i3 = (this.i3 & 0x01);
                    public::mstate.esp = (public::mstate.esp - 4);
                    this.i3 = (this.i3 + this.i6);
                    si32(this.i3, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___Balloc_D2A.start();
                    return;
                case 1:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i6 = this.i3;
                    if (!(this.i5 < 1))
                    {
                        this.i7 = 0;
                        this.i8 = (this.i6 + 20);
                        do 
                        {
                            this.i9 = 0;
                            si32(this.i9, this.i8);
                            this.i8 = (this.i8 + 4);
                            this.i7 = (this.i7 + 1);
                        } while (!(this.i7 >= this.i5));
                    };
                    if (this.i2 < 1) goto _label_4;
                    this.i7 = 0;
                    this.i8 = this.i7;
                    
                _label_1: 
                    this.i9 = (this.i4 + this.i8);
                    this.i9 = li32(this.i9 + 20);
                    if (this.i9 == 0) goto _label_3;
                    this.i10 = 20;
                    this.i11 = 0;
                    this.i12 = (this.i6 + this.i8);
                    this.i13 = this.i11;
                    this.i14 = this.i11;
                    this.i15 = this.i11;
                    
                _label_2: 
                    this.i16 = 0;
                    this.i17 = (this.i0 + this.i10);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i17 = li32(this.i17);
                    si32(this.i17, public::mstate.esp);
                    si32(this.i16, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    si32(this.i11, (public::mstate.esp + 12));
                    this.i17 = (this.i12 + this.i10);
                    this.i18 = li32(this.i17);
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[___muldi3]());
                case 2:
                    this.i19 = public::mstate.eax;
                    this.i20 = public::mstate.edx;
                    this.i14 = __addc(this.i18, this.i14);
                    this.i13 = __adde(this.i13, this.i16);
                    this.i14 = __addc(this.i14, this.i19);
                    this.i13 = __adde(this.i13, this.i20);
                    si32(this.i14, this.i17);
                    this.i10 = (this.i10 + 4);
                    this.i14 = (this.i15 + 1);
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i14 >= this.i1))
                    {
                        this.i15 = this.i14;
                        this.i14 = this.i13;
                        this.i13 = this.i16;
                        goto _label_2;
                    };
                    this.i9 = (this.i7 + this.i14);
                    this.i9 = (this.i9 << 2);
                    this.i9 = (this.i3 + this.i9);
                    si32(this.i13, (this.i9 + 20));
                    
                _label_3: 
                    this.i8 = (this.i8 + 4);
                    this.i7 = (this.i7 + 1);
                    if (!(this.i7 >= this.i2)) goto _label_1;
                    
                _label_4: 
                    if (!(this.i5 > 0))
                    {
                        this.i1 = this.i5;
                        goto _label_7;
                        
                    _label_5: 
                        this.i0 = (this.i2 + -1);
                        this.i2 = (this.i1 + 1);
                        if (!(this.i0 < 1))
                        {
                            this.i1 = this.i0;
                            this.i0 = this.i2;
                            goto _label_6;
                        };
                        this.i1 = this.i0;
                        goto _label_7;
                    };
                    this.i0 = 0;
                    this.i1 = (this.i2 + this.i1);
                    
                _label_6: 
                    this.i2 = this.i1;
                    this.i1 = this.i0;
                    this.i0 = (this.i1 ^ 0xFFFFFFFF);
                    this.i0 = (this.i5 + this.i0);
                    this.i0 = (this.i0 << 2);
                    this.i0 = (this.i3 + this.i0);
                    this.i0 = li32(this.i0 + 20);
                    if (this.i0 == 0) goto _label_5;
                    this.i1 = this.i2;
                    
                _label_7: 
                    this.i0 = this.i1;
                    si32(this.i0, (this.i3 + 16));
                    public::mstate.eax = this.i3;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in ___mult_D2A");
            };
        }


    }
}

