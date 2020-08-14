package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___srefill extends Machine 
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
            var _local_1:FSM___srefill;
            _local_1 = new (FSM___srefill)();
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
                    this.i1 = li8(___sdidinit_2E_b);
                    if (!(!(this.i1 == 0)))
                    {
                        this.i1 = _usual;
                        this.i2 = _usual_extra;
                        this.i3 = 0;
                        this.i1 = (this.i1 + 56);
                        do 
                        {
                            si32(this.i2, this.i1);
                            this.i2 = (this.i2 + 148);
                            this.i1 = (this.i1 + 88);
                            this.i3 = (this.i3 + 1);
                        } while (!(this.i3 == 17));
                        this.i1 = 1;
                        si8(this.i1, ___cleanup_2E_b);
                        si8(this.i1, ___sdidinit_2E_b);
                    };
                    this.i1 = li32(this.i0 + 56);
                    this.i2 = li32(this.i1 + 16);
                    this.i1 = (this.i1 + 16);
                    this.i3 = (this.i0 + 56);
                    if (!(!(this.i2 == 0)))
                    {
                        this.i2 = -1;
                        si32(this.i2, this.i1);
                    };
                    this.i1 = 0;
                    si32(this.i1, (this.i0 + 4));
                    this.i1 = li16(this.i0 + 12);
                    this.i2 = (this.i0 + 12);
                    this.i4 = (this.i0 + 4);
                    this.i5 = this.i1;
                    this.i6 = (this.i1 & 0x20);
                    if (!(this.i6 == 0))
                    {
                        
                    _label_1: 
                        this.i0 = -1;
                        goto _label_15;
                    };
                    this.i6 = (this.i5 & 0x04);
                    if (!(this.i6 == 0)) goto _label_3;
                    this.i3 = (this.i5 & 0x10);
                    if (!(!(this.i3 == 0)))
                    {
                        this.i0 = 9;
                        si32(this.i0, _val_2E_1440);
                        this.i0 = li16(this.i2);
                        goto _label_14;
                    };
                    this.i3 = (this.i5 & 0x08);
                    if (this.i3 == 0) goto _label_2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___sflush.start();
                    return;
                case 1:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (!(this.i1 == 0)) goto _label_1;
                    this.i1 = 0;
                    this.i3 = li16(this.i2);
                    si32(this.i1, (this.i0 + 8));
                    this.i3 = (this.i3 | 0x04);
                    si32(this.i1, (this.i0 + 24));
                    this.i1 = (this.i3 & 0xFFFFFFF7);
                    si16(this.i1, this.i2);
                    this.i1 = li32(this.i0 + 16);
                    if (this.i1 == 0) goto _label_6;
                    goto _label_7;
                    
                _label_2: 
                    this.i3 = (this.i1 | 0x04);
                    si16(this.i3, this.i2);
                    this.i3 = li32(this.i0 + 16);
                    if (this.i3 == 0) goto _label_6;
                    goto _label_7;
                    
                _label_3: 
                    this.i1 = li32(this.i0 + 48);
                    this.i5 = (this.i0 + 48);
                    if (this.i1 == 0) goto _label_5;
                    this.i6 = (this.i0 + 64);
                    if (this.i1 == this.i6) goto _label_4;
                    this.i6 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 2:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_4: 
                    this.i1 = 0;
                    si32(this.i1, this.i5);
                    this.i1 = li32(this.i0 + 60);
                    si32(this.i1, this.i4);
                    if (!(this.i1 == 0))
                    {
                        this.i2 = 0;
                        this.i4 = li32(this.i3);
                        this.i4 = li32(this.i4);
                        si32(this.i4, this.i0);
                        public::mstate.eax = this.i2;
                        goto _label_16;
                    };
                    
                _label_5: 
                    this.i1 = li32(this.i0 + 16);
                    if (!(this.i1 == 0)) goto _label_7;
                    
                _label_6: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___smakebuf.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_7: 
                    this.i1 = li16(this.i2);
                    this.i3 = (this.i1 & 0x03);
                    if (this.i3 == 0) goto _label_13;
                    this.i3 = ___sglue;
                    this.i1 = (this.i1 | 0xFFFF8000);
                    si16(this.i1, this.i2);
                    this.i1 = 0;
                    
                _label_8: 
                    this.i5 = li32(this.i3 + 4);
                    this.i6 = li32(this.i3 + 8);
                    this.i7 = (this.i5 + -1);
                    if (!(this.i7 > -1)) goto _label_12;
                    this.i5 = (this.i5 + -1);
                    
                _label_9: 
                    this.i7 = li16(this.i6 + 12);
                    this.i8 = (this.i7 << 16);
                    this.i9 = this.i6;
                    this.i8 = (this.i8 >> 16);
                    if (!(this.i8 > 0)) goto _label_11;
                    this.i7 = (this.i7 & 0x09);
                    if (!(this.i7 == 9))
                    {
                        this.i9 = 0;
                        goto _label_10;
                    };
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i9, public::mstate.esp);
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___sflush.start();
                    return;
                case 4:
                    this.i9 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_10: 
                    this.i7 = this.i9;
                    this.i1 = (this.i7 | this.i1);
                    
                _label_11: 
                    this.i6 = (this.i6 + 88);
                    this.i5 = (this.i5 + -1);
                    if (this.i5 > -1) goto _label_17;
                    
                _label_12: 
                    this.i3 = li32(this.i3);
                    if (!(this.i3 == 0)) goto _label_8;
                    this.i1 = li16(this.i2);
                    this.i3 = (this.i1 & 0x7FFF);
                    si16(this.i3, this.i2);
                    this.i1 = (this.i1 & 0x09);
                    if (!(this.i1 == 9)) goto _label_13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___sflush.start();
                    return;
                case 5:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_13: 
                    this.i1 = li32(this.i0 + 16);
                    si32(this.i1, this.i0);
                    this.i3 = li32(this.i0 + 20);
                    this.i5 = li32(this.i0 + 36);
                    this.i6 = li32(this.i0 + 28);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i5]());
                    return;
                case 6:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(this.i1 < 1))
                    {
                        this.i3 = li16(this.i2);
                        this.i5 = (this.i3 & 0x1000);
                        if (!(this.i5 == 0))
                        {
                            this.i5 = 2147483647;
                            this.i6 = li32(this.i0 + 80);
                            this.i7 = li32(this.i0 + 84);
                            this.i8 = (this.i1 >> 31);
                            this.i9 = -1;
                            this.i9 = __subc(this.i9, this.i1);
                            this.i5 = __sube(this.i5, this.i8);
                            this.i0 = (this.i0 + 80);
                            this.i10 = ((this.i7 > this.i5) ? 1 : 0);
                            this.i9 = ((uint(this.i6) > uint(this.i9)) ? 1 : 0);
                            this.i5 = ((this.i7 == this.i5) ? 1 : 0);
                            this.i11 = this.i1;
                            this.i5 = ((this.i5 != 0) ? this.i9 : this.i10);
                            if (!(!(this.i5 == 0)))
                            {
                                this.i3 = __addc(this.i6, this.i11);
                                this.i5 = __adde(this.i7, this.i8);
                                si32(this.i3, this.i0);
                                si32(this.i5, (this.i0 + 4));
                            }
                            else
                            {
                                this.i0 = (this.i3 & 0xFFFFEFFF);
                                si16(this.i0, this.i2);
                            };
                        };
                    }
                    else
                    {
                        if (!(this.i1 > -1))
                        {
                            this.i0 = li16(this.i2);
                            this.i0 = (this.i0 & 0xFFFFEFFF);
                            si16(this.i0, this.i2);
                        };
                    };
                    si32(this.i1, this.i4);
                    this.i0 = li16(this.i2);
                    this.i0 = (this.i0 & 0xFFFFDFFF);
                    si16(this.i0, this.i2);
                    if (!(this.i1 < 1))
                    {
                        this.i0 = 0;
                    }
                    else
                    {
                        if (!(!(this.i1 == 0)))
                        {
                            this.i4 = -1;
                            this.i0 = (this.i0 | 0x20);
                            si16(this.i0, this.i2);
                            public::mstate.eax = this.i4;
                            goto _label_16;
                        };
                        this.i1 = 0;
                        si32(this.i1, this.i4);
                        
                    _label_14: 
                        this.i0 = (this.i0 | 0x40);
                        si16(this.i0, this.i2);
                        this.i0 = -1;
                    };
                    
                _label_15: 
                    public::mstate.eax = this.i0;
                    
                _label_16: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_17: 
                    goto _label_9;
                default:
                    throw ("Invalid state in ___srefill");
            };
        }


    }
} cmodule.lua_wrapper

