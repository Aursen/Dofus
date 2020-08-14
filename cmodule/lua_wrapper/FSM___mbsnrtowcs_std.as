package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___mbsnrtowcs_std extends Machine 
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
            var _local_1:FSM___mbsnrtowcs_std;
            _local_1 = new (FSM___mbsnrtowcs_std)();
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
                    public::mstate.esp = (public::mstate.esp - 4);
                    this.i0 = li32(public::mstate.ebp + 12);
                    this.i1 = li32(this.i0);
                    this.i2 = li32(public::mstate.ebp + 8);
                    this.i3 = li32(public::mstate.ebp + 16);
                    this.i4 = li32(public::mstate.ebp + 20);
                    this.i5 = li32(public::mstate.ebp + 24);
                    if (!(this.i2 == 0))
                    {
                        this.i6 = 0;
                        this.i7 = this.i6;
                        goto _label_8;
                    };
                    this.i0 = (public::mstate.ebp + -4);
                    this.i2 = li32(___mbrtowc);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i2]());
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i0 == -2))
                    {
                        if (this.i0 == -1) goto _label_11;
                        if (!(this.i0 == 0)) goto _label_1;
                    };
                    this.i0 = 0;
                    goto _label_12;
                    
                _label_1: 
                    this.i2 = 0;
                    this.i4 = this.i2;
                    
                _label_2: 
                    this.i6 = (public::mstate.ebp + -4);
                    this.i7 = li32(___mbrtowc);
                    this.i2 = (this.i2 + this.i0);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i0 = (this.i3 - this.i0);
                    this.i3 = (this.i1 + this.i2);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i7]());
                    return;
                case 2:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i3 = (this.i4 + 1);
                    if (!(this.i6 == -2))
                    {
                        if (this.i6 == -1) goto _label_11;
                        if (!(this.i6 == 0)) goto _label_3;
                    };
                    this.i0 = this.i3;
                    goto _label_12;
                    
                _label_3: 
                    this.i4 = this.i3;
                    this.i3 = this.i0;
                    this.i0 = this.i6;
                    goto _label_2;
                    
                _label_4: 
                    this.i10 = li32(___mbrtowc);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i10]());
                    return;
                case 3:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i2 == -2))
                    {
                        if (this.i2 == 0) goto _label_5;
                        if (!(this.i2 == -1)) goto _label_7;
                        this.i2 = -1;
                        si32(this.i3, this.i0);
                        public::mstate.eax = this.i2;
                        goto _label_10;
                    };
                    this.i2 = (this.i6 + this.i9);
                    this.i2 = (this.i1 + this.i2);
                    goto _label_6;
                    
                _label_5: 
                    this.i2 = 0;
                    
                _label_6: 
                    si32(this.i2, this.i0);
                    goto _label_9;
                    
                _label_7: 
                    this.i3 = (this.i8 + 4);
                    this.i7 = (this.i7 + 1);
                    this.i8 = (this.i9 - this.i2);
                    this.i6 = (this.i6 + this.i2);
                    this.i2 = this.i3;
                    this.i3 = this.i8;
                    
                _label_8: 
                    this.i8 = this.i2;
                    this.i9 = this.i3;
                    this.i3 = (this.i1 + this.i6);
                    this.i2 = this.i8;
                    if (!(this.i7 == this.i4)) goto _label_4;
                    si32(this.i3, this.i0);
                    
                _label_9: 
                    public::mstate.eax = this.i7;
                    do 
                    {
                        
                    _label_10: 
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                        
                    _label_11: 
                        this.i0 = -1;
                        
                    _label_12: 
                        public::mstate.eax = this.i0;
                    } while (true);
                default:
                    throw ("Invalid state in ___mbsnrtowcs_std");
            };
        }


    }
} cmodule.lua_wrapper

