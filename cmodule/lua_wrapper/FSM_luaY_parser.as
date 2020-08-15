package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaY_parser extends Machine 
    {

        public static const intRegCount:int = 11;
        public static const NumberRegCount:int = 1;

        public var i10:int;
        public var f0:Number;
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
            var _local_1:FSM_luaY_parser;
            _local_1 = new (FSM_luaY_parser)();
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
                    public::mstate.esp = (public::mstate.esp - 640);
                    this.i0 = (public::mstate.ebp + -64);
                    this.i1 = li32(public::mstate.ebp + 16);
                    this.i2 = li32(public::mstate.ebp + 20);
                    si32(this.i1, (public::mstate.ebp + -16));
                    this.i1 = li8(this.i2);
                    this.i0 = (this.i0 + 48);
                    this.i3 = li32(public::mstate.ebp + 8);
                    this.i4 = li32(public::mstate.ebp + 12);
                    this.i5 = this.i2;
                    if (this.i1 == 0) goto _label_6;
                    this.i1 = this.i5;
                    do 
                    {
                        this.i6 = li8(this.i1 + 1);
                        this.i1 = (this.i1 + 1);
                        this.i7 = this.i1;
                        if (this.i6 == 0) goto _label_7;
                        this.i1 = this.i7;
                    } while (true);
                    
                _label_1: 
                    this.i1 = (public::mstate.ebp + -4);
                    this.i3 = li32(this.i0 + 16);
                    this.i4 = li32(this.i0 + 8);
                    this.i6 = li32(this.i0 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i4]());
                    return;
                case 1:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i1 == 0)))
                    {
                        
                    _label_2: 
                        this.i0 = -1;
                        goto _label_3;
                    };
                    this.i3 = li32(public::mstate.ebp + -4);
                    if (this.i3 == 0) goto _label_2;
                    this.i3 = (this.i3 + -1);
                    si32(this.i3, this.i0);
                    si32(this.i1, (this.i0 + 4));
                    this.i3 = li8(this.i1);
                    this.i1 = (this.i1 + 1);
                    si32(this.i1, (this.i0 + 4));
                    this.i0 = this.i3;
                    
                _label_3: 
                    this.i1 = (public::mstate.ebp + -640);
                    si32(this.i0, this.i2);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = (public::mstate.ebp + -64);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_open_func.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(public::mstate.ebp + -640);
                    this.i2 = 2;
                    si8(this.i2, (this.i0 + 74));
                    this.i0 = li32(this.i8);
                    si32(this.i0, this.i7);
                    this.i0 = li32(this.i5);
                    if (!(this.i0 == 287))
                    {
                        this.i2 = 287;
                        si32(this.i0, (public::mstate.ebp + -52));
                        this.f0 = lf64(public::mstate.ebp + -36);
                        sf64(this.f0, (public::mstate.ebp + -48));
                        si32(this.i2, this.i5);
                        goto _label_4;
                    };
                    this.i0 = (public::mstate.ebp + -64);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = (this.i0 + 16);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_llex.start();
                    return;
                case 3:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i0, (public::mstate.ebp + -52));
                    
                _label_4: 
                    this.i0 = (public::mstate.ebp + -64);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_chunk.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i0 = li32(public::mstate.ebp + -52);
                    if (this.i0 == 287) goto _label_5;
                    this.i0 = 287;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = (public::mstate.ebp + -64);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_error_expected.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_5: 
                    this.i0 = (public::mstate.ebp + -64);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_close_func.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i0 = li32(this.i1);
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_6: 
                    this.i1 = this.i2;
                    
                _label_7: 
                    this.i6 = 46;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = (this.i1 - this.i5);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 7:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si8(this.i6, (public::mstate.ebp + -8));
                    si32(this.i3, (public::mstate.ebp + -24));
                    this.i2 = 287;
                    si32(this.i2, (public::mstate.ebp + -40));
                    si32(this.i4, (public::mstate.ebp + -20));
                    this.i2 = 0;
                    si32(this.i2, (public::mstate.ebp + -28));
                    this.i2 = 1;
                    si32(this.i2, (public::mstate.ebp + -60));
                    si32(this.i2, (public::mstate.ebp + -56));
                    si32(this.i1, (public::mstate.ebp + -12));
                    this.i1 = li32(this.i0);
                    this.i2 = li32(this.i3 + 16);
                    this.i4 = li32(this.i1 + 8);
                    this.i5 = li32(this.i1);
                    this.i6 = li32(this.i2 + 12);
                    this.i7 = li32(this.i2 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i8 = 32;
                    si32(this.i7, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i8, (public::mstate.esp + 12));
                    this.i5 = (public::mstate.ebp + -64);
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i6]());
                    return;
                case 8:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i7 = (this.i5 + 8);
                    this.i8 = (this.i5 + 4);
                    this.i9 = (this.i5 + 44);
                    this.i5 = (this.i5 + 24);
                    if (!(this.i6 == 0)) goto _label_8;
                    this.i10 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_8: 
                    this.i3 = 32;
                    this.i10 = li32(this.i2 + 68);
                    this.i4 = (32 - this.i4);
                    this.i4 = (this.i4 + this.i10);
                    si32(this.i4, (this.i2 + 68));
                    si32(this.i6, this.i1);
                    this.i0 = li32(this.i0);
                    si32(this.i3, (this.i0 + 8));
                    this.i0 = li32(this.i9);
                    this.i1 = li32(this.i0);
                    this.i2 = (this.i1 + -1);
                    si32(this.i2, this.i0);
                    this.i0 = li32(this.i9);
                    this.i2 = (public::mstate.ebp + -64);
                    if (this.i1 == 0) goto _label_1;
                    this.i1 = li32(this.i0 + 4);
                    this.i3 = li8(this.i1);
                    this.i1 = (this.i1 + 1);
                    si32(this.i1, (this.i0 + 4));
                    this.i0 = this.i3;
                    goto _label_3;
                default:
                    throw ("Invalid state in _luaY_parser");
            };
        }


    }
}

