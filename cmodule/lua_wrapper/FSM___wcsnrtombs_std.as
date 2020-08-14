package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___wcsnrtombs_std extends Machine 
    {

        public static const intRegCount:int = 17;
        public static const NumberRegCount:int = 0;

        public var i10:int;
        public var i11:int;
        public var i12:int;
        public var i13:int;
        public var i14:int;
        public var i15:int;
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


        public static function start():void
        {
            var _local_1:FSM___wcsnrtombs_std;
            _local_1 = new (FSM___wcsnrtombs_std)();
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
                    public::mstate.esp = (public::mstate.esp - 144);
                    this.i0 = li32(public::mstate.ebp + 12);
                    this.i1 = li32(this.i0);
                    this.i2 = li32(public::mstate.ebp + 8);
                    this.i3 = li32(public::mstate.ebp + 16);
                    this.i4 = li32(public::mstate.ebp + 20);
                    this.i5 = li32(public::mstate.ebp + 24);
                    if (this.i2 == 0) goto _label_3;
                    this.i6 = 0;
                    this.i7 = (public::mstate.ebp + -16);
                    this.i8 = (public::mstate.ebp + -144);
                    this.i9 = this.i5;
                    this.i10 = this.i6;
                    this.i11 = this.i6;
                    goto _label_10;
                    
                _label_1: 
                    this.i6 = 0;
                    this.i2 = (this.i3 + -1);
                    this.i4 = -1;
                    this.i0 = (public::mstate.ebp + -16);
                    this.i3 = this.i1;
                    this.i1 = this.i6;
                    
                _label_2: 
                    this.i6 = li32(___wcrtomb);
                    this.i7 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i6]());
                    return;
                case 1:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i7 = this.i3;
                    if (!(!(this.i6 == -1)))
                    {
                        this.i1 = -1;
                        goto _label_11;
                    };
                    this.i7 = li32(this.i7);
                    if (!(!(this.i7 == 0)))
                    {
                        this.i1 = (this.i1 + this.i6);
                        this.i1 = (this.i1 + -1);
                        goto _label_6;
                    };
                    this.i3 = (this.i3 + 4);
                    this.i4 = (this.i4 + 1);
                    this.i1 = (this.i6 + this.i1);
                    if (this.i2 == this.i4) goto _label_11;
                    goto _label_2;
                    
                _label_3: 
                    if (!(this.i3 == 0)) goto _label_1;
                    this.i1 = 0;
                    goto _label_11;
                    
                _label_4: 
                    this.i14 = li32(___mb_cur_max);
                    if (uint(this.i14) >= uint(this.i1)) goto _label_8;
                    this.i14 = li32(___wcrtomb);
                    this.i15 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i15, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i14]());
                    return;
                case 2:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(this.i6 == -1))
                    {
                        goto _label_9;
                    };
                    
                _label_5: 
                    this.i1 = -1;
                    si32(this.i4, this.i0);
                    
                _label_6: 
                    public::mstate.eax = this.i1;
                    
                _label_7: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_8: 
                    this.i14 = 128;
                    this.i15 = this.i8;
                    this.i16 = this.i9;
                    memcpy(this.i15, this.i16, this.i14);
                    this.i14 = li32(___wcrtomb);
                    this.i15 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i15, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i14]());
                    return;
                case 3:
                    this.i14 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i14 == -1))) goto _label_5;
                    if (!(uint(this.i14) <= uint(this.i1)))
                    {
                        this.i1 = 128;
                        this.i6 = this.i9;
                        this.i11 = this.i8;
                        memcpy(this.i6, this.i11, this.i1);
                    }
                    else
                    {
                        this.i15 = this.i7;
                        this.i16 = this.i14;
                        memcpy(this.i6, this.i15, this.i16);
                        this.i6 = this.i14;
                        
                    _label_9: 
                        this.i4 = li32(this.i4);
                        if (!(!(this.i4 == 0)))
                        {
                            this.i1 = 0;
                            this.i6 = (this.i10 + this.i6);
                            si32(this.i1, this.i0);
                            this.i1 = (this.i6 + -1);
                            goto _label_6;
                        };
                        this.i4 = (this.i13 + 4);
                        this.i12 = (this.i12 + 1);
                        this.i13 = (this.i6 + this.i10);
                        this.i14 = (this.i1 - this.i6);
                        this.i6 = (this.i11 + this.i6);
                        this.i1 = this.i4;
                        this.i10 = this.i12;
                        this.i11 = this.i13;
                        this.i4 = this.i14;
                        
                    _label_10: 
                        this.i13 = this.i1;
                        this.i12 = this.i10;
                        this.i10 = this.i11;
                        this.i1 = this.i4;
                        this.i11 = this.i6;
                        this.i6 = (this.i2 + this.i11);
                        this.i4 = this.i13;
                        if (!(this.i1 == 0))
                        {
                            if (!(this.i12 == this.i3)) goto _label_4;
                        };
                    };
                    si32(this.i4, this.i0);
                    public::mstate.eax = this.i10;
                    goto _label_7;
                    
                _label_11: 
                    this.i0 = this.i1;
                    public::mstate.eax = this.i0;
                    goto _label_7;
                default:
                    throw ("Invalid state in ___wcsnrtombs_std");
            };
        }


    }
} cmodule.lua_wrapper

