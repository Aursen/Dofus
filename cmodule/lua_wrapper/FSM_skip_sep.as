package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_skip_sep extends Machine 
    {

        public static const intRegCount:int = 10;
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
        public var i9:int;


        public static function start():void
        {
            var _local_1:FSM_skip_sep;
            _local_1 = new (FSM_skip_sep)();
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
                    this.i1 = li32(this.i0);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_save.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i0 + 44);
                    this.i3 = li32(this.i2);
                    this.i4 = (this.i3 + -1);
                    si32(this.i4, this.i2);
                    this.i2 = li32(this.i0 + 44);
                    this.i4 = (this.i0 + 44);
                    this.i5 = this.i0;
                    if (!(this.i3 == 0))
                    {
                        this.i3 = li32(this.i2 + 4);
                        this.i6 = li8(this.i3);
                        this.i3 = (this.i3 + 1);
                        si32(this.i3, (this.i2 + 4));
                        si32(this.i6, this.i5);
                        if (this.i6 == 61) goto _label_3;
                        this.i0 = 0;
                        this.i2 = this.i6;
                        goto _label_8;
                    };
                    this.i3 = (public::mstate.ebp + -8);
                    this.i6 = li32(this.i2 + 16);
                    this.i7 = li32(this.i2 + 8);
                    this.i8 = li32(this.i2 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i7]());
                    return;
                case 2:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i3 == 0)))
                    {
                        
                    _label_1: 
                        this.i2 = -1;
                        goto _label_2;
                    };
                    this.i6 = li32(public::mstate.ebp + -8);
                    if (this.i6 == 0) goto _label_1;
                    this.i6 = (this.i6 + -1);
                    si32(this.i6, this.i2);
                    si32(this.i3, (this.i2 + 4));
                    this.i6 = li8(this.i3);
                    this.i3 = (this.i3 + 1);
                    si32(this.i3, (this.i2 + 4));
                    this.i2 = this.i6;
                    
                _label_2: 
                    this.i3 = 0;
                    si32(this.i2, this.i5);
                    goto _label_7;
                    
                _label_3: 
                    this.i2 = 0;
                    this.i3 = this.i6;
                    
                _label_4: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_save.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i4);
                    this.i6 = li32(this.i3);
                    this.i7 = (this.i6 + -1);
                    si32(this.i7, this.i3);
                    this.i3 = li32(this.i4);
                    if (!(this.i6 == 0))
                    {
                        this.i6 = li32(this.i3 + 4);
                        this.i7 = li8(this.i6);
                        this.i6 = (this.i6 + 1);
                        si32(this.i6, (this.i3 + 4));
                        si32(this.i7, this.i5);
                        this.i3 = (this.i2 + 1);
                        this.i2 = this.i7;
                        goto _label_7;
                    };
                    this.i6 = (public::mstate.ebp + -4);
                    this.i7 = li32(this.i3 + 16);
                    this.i8 = li32(this.i3 + 8);
                    this.i9 = li32(this.i3 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i8]());
                    return;
                case 4:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i6 == 0)))
                    {
                        
                    _label_5: 
                        this.i3 = -1;
                        goto _label_6;
                    };
                    this.i7 = li32(public::mstate.ebp + -4);
                    if (this.i7 == 0) goto _label_5;
                    this.i7 = (this.i7 + -1);
                    si32(this.i7, this.i3);
                    si32(this.i6, (this.i3 + 4));
                    this.i7 = li8(this.i6);
                    this.i6 = (this.i6 + 1);
                    si32(this.i6, (this.i3 + 4));
                    this.i3 = this.i7;
                    
                _label_6: 
                    si32(this.i3, this.i5);
                    this.i6 = (this.i2 + 1);
                    this.i2 = this.i3;
                    this.i3 = this.i6;
                    
                _label_7: 
                    this.i6 = this.i2;
                    this.i2 = this.i3;
                    if (!(this.i6 == 61))
                    {
                        this.i0 = this.i2;
                        this.i2 = this.i6;
                        
                    _label_8: 
                        if (!(this.i2 == this.i1))
                        {
                            this.i0 = (this.i0 ^ 0xFFFFFFFF);
                        };
                        public::mstate.eax = this.i0;
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                    };
                    this.i3 = this.i6;
                    goto _label_4;
                default:
                    throw ("Invalid state in _skip_sep");
            };
        }


    }
} cmodule.lua_wrapper

