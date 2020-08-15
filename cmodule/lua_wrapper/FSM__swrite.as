package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM__swrite extends Machine 
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
            var _local_1:FSM__swrite;
            _local_1 = new (FSM__swrite)();
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
                    this.i1 = li16(this.i0 + 12);
                    this.i2 = (this.i0 + 12);
                    this.i3 = li32(public::mstate.ebp + 12);
                    this.i4 = li32(public::mstate.ebp + 16);
                    this.i1 = (this.i1 & 0x0100);
                    if (this.i1 == 0) goto _label_1;
                    this.i1 = 0;
                    this.i5 = li32(_val_2E_1440);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i6 = 2;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    si32(this.i6, (public::mstate.esp + 12));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM__sseek.start();
                    return;
                case 1:
                    this.i1 = public::mstate.eax;
                    this.i6 = public::mstate.edx;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i1 = (this.i1 & this.i6);
                    if (!(!(this.i1 == -1)))
                    {
                        this.i1 = li16(this.i2);
                        this.i1 = (this.i1 & 0x0400);
                        if (!(this.i1 == 0))
                        {
                            this.i0 = -1;
                            goto _label_4;
                        };
                    };
                    si32(this.i5, _val_2E_1440);
                    
                _label_1: 
                    this.i1 = li32(this.i0 + 44);
                    this.i5 = li32(this.i0 + 28);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i1]());
                    return;
                case 2:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(this.i1 < 0))
                    {
                        this.i3 = li16(this.i2);
                        this.i4 = (this.i3 & 0x1100);
                        if (!(!(this.i4 == 0x1100)))
                        {
                            this.i4 = 2147483647;
                            this.i5 = li32(this.i0 + 80);
                            this.i6 = li32(this.i0 + 84);
                            this.i7 = (this.i1 >> 31);
                            this.i8 = -1;
                            this.i8 = __subc(this.i8, this.i1);
                            this.i4 = __sube(this.i4, this.i7);
                            this.i0 = (this.i0 + 80);
                            this.i9 = ((this.i6 > this.i4) ? 1 : 0);
                            this.i8 = ((uint(this.i5) > uint(this.i8)) ? 1 : 0);
                            this.i4 = ((this.i6 == this.i4) ? 1 : 0);
                            this.i10 = this.i1;
                            this.i4 = ((this.i4 != 0) ? this.i8 : this.i9);
                            if (!(!(this.i4 == 0)))
                            {
                                this.i2 = __addc(this.i5, this.i10);
                                this.i3 = __adde(this.i6, this.i7);
                                si32(this.i2, this.i0);
                                si32(this.i3, (this.i0 + 4));
                                goto _label_3;
                            };
                        };
                        this.i0 = (this.i3 & 0xFFFFEFFF);
                        
                    _label_2: 
                        si16(this.i0, this.i2);
                        
                    _label_3: 
                        public::mstate.eax = this.i1;
                    }
                    else
                    {
                        if (this.i1 < 0) goto _label_5;
                        this.i0 = this.i1;
                        
                    _label_4: 
                        public::mstate.eax = this.i0;
                    };
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_5: 
                    this.i0 = li16(this.i2);
                    this.i0 = (this.i0 & 0xFFFFEFFF);
                    goto _label_2;
                default:
                    throw ("Invalid state in __swrite");
            };
        }


    }
}

